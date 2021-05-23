import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodel/TotalPoints.dart';
import '../viewmodel/ExercisePage.dart';

enum VerificationResult {
  CORRECT,
  INCORRECT
}


class GapFillingExercisePageState extends State<ExercisePage>{

  String exerciseKey;
  GapFillingExercisePageState(this.exerciseKey);
  Exercise exercise;

  static const scale = 7.2;

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

  @override
  Widget build(BuildContext context) {
    List<Question> questions = DataStorage.db.getAllQuestions(this.exerciseKey);
    TotalPoints totalPoints = new TotalPoints();
    List<Widget> input = List<Widget>();
    exercise = DataStorage.db.exercises.get(this.exerciseKey);

    List<Widget> _buildButtonsWithNames() {

      for (int i = 0; i < questions.length; i++) {
        String question = (i + 1).toString() + ". " + questions[i].question;
        List<String> questionParts = question.split("_");
        double maxWidth = questionParts[0].length + questionParts[1].length + 5.0;

        double questionFillLength = questions[i].answer.length.toDouble() < 3? 3.toDouble(): questions[i].answer.length.toDouble();

        input.add(Container(
            width: (question.length + questionFillLength) * scale,
            child:
            TextFormField(
                    controller: TextEditingController(),
                    decoration: new InputDecoration(
                        prefixText: questionParts[0],
                        hintText: "_" * questionFillLength.toInt(),
                        suffixText: questionParts[1],
                        prefixIconConstraints: BoxConstraints(maxWidth: maxWidth),
                    ),
        )
        )
        );

      }
      return input;
    }

    Widget _buildPopupDialog(BuildContext context, List<Question> questions, List<String> answers, List<VerificationResult> results) {

      List<Widget> resultsDisplay = List<Widget>();
      for (int i = 0; i < answers.length; i++) {
        Color c = results[i] == VerificationResult.CORRECT? Colors.green: Colors.red;
        resultsDisplay.add(
          new Text(
              (i + 1).toString() + ". " + questions[i].question.replaceFirst("_", answers[i]),
            style: TextStyle(color: c),
          )
        );
      }


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
          // TODO: OPTIMISE
          List<String> answers = List<String>();
          input.forEach((element) {
            Container c = element;
            TextFormField tff = c.child;
            answers.add(tff.controller.text);
          });

          List<VerificationResult> results = check(questions, answers);

          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context, questions, answers, results),
          ).then((value) => Navigator.pop(context));
        },

      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise.description,
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
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildButtonsWithNames() + [_submitButton()]
        ),
      ),
    );
  }
}
