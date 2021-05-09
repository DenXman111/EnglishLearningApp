import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:english_learning_app/viewmodel/SynsAntonymsGamePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodel/TotalPoints.dart';

enum VerificationResult {
  CORRECT,
  INCORRECT
}

// https://api.flutter.dev/flutter/widgets/Draggable-class.html


class SynonymsAntonymsPageState extends State<SynsAntonymsGamePage>{

  SynonymsAntonymsPageState();

  static const scale = 7.2;

  static const int questionsNumber = 5;

  List<VerificationResult> check(List<Question> questions, List<String> answers) {
    List<VerificationResult> results = List<VerificationResult>();
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].answer.toLowerCase() == answers[i].toLowerCase().trim()) {
        results.add(VerificationResult.CORRECT);
        DataStorage.db.setPoint(questions[i]);
      } else {
        results.add(VerificationResult.INCORRECT);
      }
    }
    return results;
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

  List<Map<String, dynamic>> userAnswers = List();

  List<Draggable> _draggable(List<Question> questions) {

    List<Draggable> draggable = [];

    List<String> answers = [];

    questions.forEach((element) {

      List<String> toMatch = element.answer.split("| A:");

      toMatch = toMatch + toMatch[0].split("S:");
      toMatch.removeAt(0);
      print(toMatch);
      List<String> last = [];
      toMatch.forEach((element) {
        last = last + element.split(",");
      });

      last.forEach((element) {
        var clean = element.trim();
        if (clean.length > 1)
          answers.add(clean);
      });

      answers.forEach((element) {
        draggable.add(
          Draggable<String>(
            // Data is the value this Draggable stores.
            data: element,
            child: Container(
              height: 50.0,
              width: 90.0,
              color: Colors.lightGreenAccent,
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
    });


    return draggable;
  }

  List<DragTarget> _dragtarget(List<Question> questions) {

    List<DragTarget> dragtarget = new List();
    questions.forEach((element) {
      Map<String, dynamic> display = Map();
      String word = element.question;
      display["word"] = element.question;
      var synonyms = List();
      var antonyms = List();
      display["synonyms"] = synonyms;
      display["antonyms"] = antonyms;
      userAnswers.add(display);

      String s;

      dragtarget.add(
        DragTarget<String>(
          builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
              ) {
            return Container(
              height: 100.0,
              color: Colors.grey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('$word'),
              ),
            );
          },
          onAccept: (String data) {
            print(element.question + " " + data);
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
              height: 100.0,
              color: Colors.grey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('$synonyms'),
              ),
            );
          },
          onAccept: (String data) {
            display["synonyms"].add(data);
            print(element.question + " " + data);
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
              //     width: 100.0,
              color: Colors.grey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('$antonyms'),
              ),
            );
          },
          onAccept: (String data) {

            display["antonyms"].add(data);
            print(element.question + " " + data);
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

    List<Question> questions = _questions();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
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
          // TODO: ADjust number of rows to screen size
          Row(
              children: synAntonyms.sublist(0, (synAntonyms.length/2).toInt())
          ),
          Row(
              children: synAntonyms.sublist((synAntonyms.length/2).toInt(), synAntonyms.length)
          ),
          Row(
            // TODO: move this row to be included in grid
            children: <Widget> [
              Container(width: MediaQuery.of(context).size.width / 3, color: Colors.grey, child: Text("", style: TextStyle(color: Colors.white,  backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300))),
              Container(width: MediaQuery.of(context).size.width / 3, color: Colors.grey, child: Text("Antonyms ", style: TextStyle(color: Colors.white,  backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300))),
              Container(width: MediaQuery.of(context).size.width / 3.5, color: Colors.grey, child: Text("Synonyms ", style: TextStyle(color: Colors.white, backgroundColor: Colors.grey, fontSize: 24, fontWeight: FontWeight.w300)),)
            ],
          ),
          Container(
            height: 1000,
              child: GridView.count(
            childAspectRatio: (itemWidth / itemHeight * 2),
            crossAxisCount: 3,
            children: _dragtarget(questions).cast<Widget>(),
          )
          )
        ]
        ),
      ),
    );
  }

}
