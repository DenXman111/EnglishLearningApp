import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodel/TotalPoints.dart';
import '../viewmodel/ExercisePage.dart';


class ExercisePageState extends State<ExercisePage>{

  String exerciseKey;
  ExercisePageState(this.exerciseKey);
  Exercise exercise;

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

        input.add(TextFormField(
            controller: TextEditingController(),
            decoration: new InputDecoration(
                prefixText: questionParts[0],
                hintText: "___",
                suffixText: questionParts[1], // new TextSpan(text: '@ipportalegre.pt').text,
                prefixIconConstraints: BoxConstraints(maxWidth: maxWidth),
            ),
        ));
      }
      return input;
    }

    Widget _submitButton() {
      return new TextButton(
        child: Text("Submit",
          style: GoogleFonts.quicksand(
          ),

        ),
        style: TextButton.styleFrom(
          primary: Colors.deepOrange,
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: () {
          input.forEach((element) {
            TextFormField tff = element;
            // TODO: add log for validation of input
            print("Input for question: " + tff.controller.text);
          });
        },
      );
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildButtonsWithNames() + [_submitButton()]
        ),
      ),
    );
  }
}
