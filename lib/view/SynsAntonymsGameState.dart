import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:english_learning_app/viewmodel/SynsAntonymsGamePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';
import '../viewmodel/TotalPoints.dart';

enum VerificationResult {
  CORRECT,
  INCORRECT
}

// https://api.flutter.dev/flutter/widgets/Draggable-class.html


class SynonymsAntonymsPageState extends State<SynsAntonymsGamePage>{

  SynonymsAntonymsPageState();

  static const scale = 7.2;

  static const int questionsNumber = 6;

  String _synonymsString(List<String> synonyms) {
    var a = "";
    synonyms.forEach((element) {
      a += element + " ";
    });
    return a;
  }

  List<Question> _questions() {
    // TODO: magic number
    List<Exercise> exercises = DataStorage.db.getAllExercises(2);
    assert (exercises.length == 1);
    List<Question> questions = DataStorage.db.getAllQuestions(exercises[0].dbKey);
    questions.shuffle();
    List<Question> unaswered = [];
    List<Question> answered = [];

    for (int i = 0; i < questions.length; i++) {
      if (questions[i].pointObtained) {
        unaswered.add(questions[i]);
        if (unaswered.length == questionsNumber)
          break;
      } else if (unaswered.length + answered.length < questionsNumber){
        answered.add(questions[i]);
      }
    }

    questions.forEach((element) {
      if (element.pointObtained) {
        unaswered.add(element);
        if (unaswered.length == questionsNumber) {

        }
      }
    });

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

    answers.forEach((element) {
      draggable.add(
        Draggable<String>(
          // Data is the value this Draggable stores.
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

  List<Widget> _dragtarget(List<Question> questions) {

    List<Widget> dragtarget = new List();

    dragtarget.add(Container(color: Colors.grey, child: Text("", style: TextStyle(color: Colors.white,  backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300))));
    dragtarget.add(Container(color: Colors.grey, child: Text("Synonyms ", style: TextStyle(color: Colors.white, backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300)),));
    dragtarget.add(Container(color: Colors.grey, child: Text("Antonyms ", style: TextStyle(color: Colors.white,  backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300))));


    questions.forEach((element) {
      Map<String, dynamic> display = Map();
      String word = element.question;
      var synonyms = List();
      var antonyms = List();
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
          onAccept: (String data) {
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
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              height: 100.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_synonymsString(synonyms.cast<String>()).toString()),
              ),
            );
          },
          onAccept: (String data) {
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
            display["antonyms"].add(data);
          },
        ),
      );

    });
    return dragtarget;
  }

  //
  @override
  Widget build(BuildContext context) {

    TotalPoints totalPoints = new TotalPoints();

    questions = _questions();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 5;
    final double itemWidth = size.width / 2;

    var synAntonyms =_draggable(questions).cast<Widget>();

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
        child: Column(children: <Widget> [
          _submitButton(),
          // TODO: ADjust number of rows to screen size
          Row(
              children: synAntonyms
          ),
          // Row(
          //     children: synAntonyms.sublist(0, (synAntonyms.length/2).toInt())
          // ),
          // Row(
          //     children: synAntonyms.sublist((synAntonyms.length/2).toInt(), synAntonyms.length)
          // ),
          Container(
            height: 1000,
              child: GridView.count(
                  childAspectRatio: (itemWidth / itemHeight * 2),
                  crossAxisCount: 3,
                  children: _dragtarget(questions).cast<Widget>(),
              )
          ),
        ]
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
    // for (int i = 0; i < results.length; i++) {
    //   Color c = results[i] == VerificationResult.CORRECT? Colors.green: Colors.red;
    //   resultsDisplay.add(
    //       new Text(
    //         (i + 1).toString() + ". " + questions[i].question.replaceFirst("_", answers[i]),
    //         style: TextStyle(color: c),
    //       )
    //   );
    // }


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
