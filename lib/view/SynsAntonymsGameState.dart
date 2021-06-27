import 'dart:async';

import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:english_learning_app/viewmodel/SynsAntonymsGamePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';
import '../viewmodel/TotalPoints.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

enum VerificationResult {
  CORRECT,
  INCORRECT
}


class SynonymsAntonymsPageState extends State<SynsAntonymsGamePage>{

  static const scale = 7.2;
  static const int questionsNumber = 6;
  static const int secondClass = 2;

  List<Widget> dragTargets;
  List<Draggable> draggable;
  bool reset = false;

  String _synonymsString(List<String> synonyms) {
    var a = "";
    synonyms.forEach((element) {
      a += element + ", ";
    });
    if (a.length > 2)
      a = a.substring(0, a.length - 2);
    return a;
  }

  List<Question> _questions() {
    if (this.questions != null)
      return this.questions;

    List<Exercise> exercises = DataStorage.db.getAllExercises(secondClass);
    assert (exercises.length == 1);
    List<Question> questions = DataStorage.db.getAllQuestions(exercises[0].dbKey);
    questions.shuffle();

    List<Question> unaswered = [];
    List<Question> answered = [];

    for (int i = 0; i < questions.length; i++) {
      if (!questions[i].pointObtained) {
        unaswered.add(questions[i]);
        if (unaswered.length == questionsNumber)
          break;
      } else if (unaswered.length + answered.length < questionsNumber){
        answered.add(questions[i]);
      }
    }

    if (unaswered.length < questionsNumber) {
      unaswered = unaswered + answered.sublist(0, questionsNumber - unaswered.length);
    }
    return unaswered;
  }

  List<Question> questions;
  Map<Question, dynamic> userAnswers = {};
  Map<Question, dynamic> correctAnswers = {};

  List<String> _getSynonyms(Question question) {
    List<String> toMatch = question.answer.split("| A:");
    toMatch.removeLast();
    toMatch = toMatch[0].split("S:");
    toMatch.removeAt(0);

    List<String> synonyms = [];
    List<String> answers = [];
    toMatch.forEach((element) {
      synonyms = synonyms + element.split(",");
    });

    synonyms.forEach((element) {
      var clean = element.trim();
      if (clean.length > 1)
        answers.add(clean);
    });
    return answers;
  }

  List<String> _getAntonyms(Question question) {
    List<String> toMatch = question.answer.split("| A:");
    toMatch.removeAt(0);

    List<String> synonyms = [];
    List<String> answers = [];
    toMatch.forEach((element) {
      synonyms = synonyms + element.split(",");
    });

    synonyms.forEach((element) {
      var clean = element.trim();
      if (clean.length > 1)
        answers.add(clean);
    });
    return answers;
  }



  List<Draggable> _draggable(List<Question> questions) {
    if (this.draggable != null) {
      return this.draggable;
    }

    List<Draggable> draggable = [];
    List<String> answers = [];

    questions.forEach((element) {
      List<String> synonyms = _getSynonyms(element);
      List<String> antonyms = _getAntonyms(element);
      Map<String, dynamic> transformed_question = {};
      transformed_question["synonyms"] = synonyms;
      transformed_question["antonyms"] = antonyms;
      correctAnswers[element] = transformed_question;
      answers = answers + synonyms + antonyms;
    });

    answers.shuffle();

    answers.forEach((element) {
      draggable.add(
        Draggable<String>(
          data: element,
          child: Container(
            height: 40.0,
            width: 90.0,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Text(element),
          ),
          feedback: Container(
            color: Colors.deepOrange,
            height: 50,
            width: 90,
            child: const Icon(Icons.directions_run),
          ),
          childWhenDragging: Container(
            height: 50.0,
            width: 90.0,
            color: Colors.pinkAccent,
            child: Center(
              child: Text(element),
            ),
          ),
        ),
      );
    });


    return draggable;
  }

  List<Widget> _dragTarget(List<Question> questions) {

    List<Widget> dragtarget = [];

    dragtarget.add(Container(color: Colors.grey, child: Text("", style: TextStyle(color: Colors.white,  backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300))));
    dragtarget.add(Container(color: Colors.grey, child: Text("Synonyms ", style: TextStyle(color: Colors.white, backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300)),));
    dragtarget.add(Container(color: Colors.grey, child: Text("Antonyms ", style: TextStyle(color: Colors.white,  backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300))));


    questions.forEach((element) {
      Map<String, dynamic> display = Map();
      String word = element.question;
      var synonyms = [];
      var antonyms = [];
      display["synonyms"] = synonyms;
      display["antonyms"] = antonyms;
      userAnswers[element] = display;

      dragtarget.add(
        DragTarget<String>(
          builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
              ) {
            return Container(
              height: 100.0,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('$word'),
              ),
            );
          },
          onAccept: (String data) {},
        ),
      );

      dragtarget.add(
        DragTarget<String>(
          builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
              ) {
            return Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              height: 150.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_synonymsString(synonyms.cast<String>()).toString()),
              ),
            );
          },
          onAccept: (String data) {
            if (!display["synonyms"].contains(data))
              display["synonyms"].add(data);
          },
        ),
      );


      dragtarget.add(
        DragTarget<String>(
          builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
              ) {
            return Container(
              height: 30.0,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_synonymsString(antonyms.cast<String>()).toString()),
              ),
            );
          },
          onAccept: (String data) {
            if (!display["antonyms"].contains(data))
              display["antonyms"].add(data);
          },
        ),
      );

    });
    return dragtarget;
  }

  List<Widget> _displayItems() {
    questions = _questions();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 5;
    final double itemWidth = size.width / 2;

    draggable = _draggable(questions);
    List<Widget> synAntonyms = draggable.cast<Widget>();

    if (dragTargets == null) {
      dragTargets = _dragTarget(questions);
    }

    var targets = dragTargets;

    int questionsPerRow = 3;
    int height = 200;
    if (kIsWeb) {
      height = 90;
      questionsPerRow = 8;
    }


    return [
      Row(children: [_submitButton(), _resetButton()]),
      Container(
          height: height.toDouble(),
          child: GridView.count(
            childAspectRatio: (itemWidth / itemHeight * 2),
            crossAxisCount: questionsPerRow,
            children: synAntonyms,
          )
      ),
      Container(
          height: 1000,
          child: GridView.count(
            childAspectRatio: (itemWidth / itemHeight * 2),
            crossAxisCount: 3,
            children: targets,
          )
      ),
    ];
  }

  //
  @override
  Widget build(BuildContext context) {

    TotalPoints totalPoints = new TotalPoints();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Match word with it's synonyms and antonyms",
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          Row(
            children: <Widget> [
              Text(totalPoints.formatter.format(totalPoints.get()), style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300)),
              Icon(Icons.stars_rounded, size: 32),
              Text(' '),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(23.0),
        child: Column(children: _displayItems()
        ),
      ),
    );
  }

  Map<String, VerificationResult> check() {
    Map<String, VerificationResult> results = {};

    correctAnswers.forEach((key, value) {
      List<String> s = userAnswers[key]["synonyms"].cast<String>();
      List<String> a = userAnswers[key]["antonyms"].cast<String>();

      List<String> correct_s = correctAnswers[key]["synonyms"].cast<String>();
      List<String> correct_a = correctAnswers[key]["antonyms"].cast<String>();

      if (s.length != correct_s.length) {
        results[key.question] = VerificationResult.INCORRECT;
      }
      else if (a.length != correct_a.length) {
        results[key.question] = VerificationResult.INCORRECT;
      } else {
          s.sort();
          a.sort();
          correct_a.sort();
          correct_s.sort();
          if (DeepCollectionEquality().equals(correct_a, a) && DeepCollectionEquality().equals(correct_s, s)) {
            results[key.question] = VerificationResult.CORRECT;
            DataStorage.db.setPoint(key);
          } else {
            results[key.question] = VerificationResult.INCORRECT;
          }
      }
    });
    return results;
  }


  Widget _submitButton() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange)
        ),
        child: new TextButton(
          child: Text("Submit", style: GoogleFonts.quicksand()),
          style: TextButton.styleFrom(
            primary: Colors.deepOrange,
            padding: EdgeInsets.all(16.0),
          ),
          onPressed: () {
            Map<String, VerificationResult> results = check();

            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context, results),
            ).then((value) => Navigator.pop(context));
          }

        ));
  }


  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _refreshPoints());
  }

  void _refreshPoints(){
    if (mounted && reset) {
      setState(() {
        reset = false;
        dragTargets = _dragTarget(questions);
      });
    }
  }

  Widget _resetButton() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange)
        ),
        child: new TextButton(
            child: Text("Reset answers", style: GoogleFonts.quicksand()),
            style: TextButton.styleFrom(
              primary: Colors.deepOrange,
              padding: EdgeInsets.all(16.0),
            ),
            onPressed: () {
              reset = true;
            }

        ));
  }

  Widget _buildPopupDialog(BuildContext context, Map<String, VerificationResult> results) {

    List<Widget> resultsDisplay = List<Widget>();

    results.forEach((key, value) {
      Color c = value == VerificationResult.CORRECT? Colors.green: Colors.red;
      resultsDisplay.add(
          new Text(
           key,
            style: TextStyle(color: c),
          )
      );
    });

    return new AlertDialog(
      title: const Text('Exercise result'),
      content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: resultsDisplay
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

}
