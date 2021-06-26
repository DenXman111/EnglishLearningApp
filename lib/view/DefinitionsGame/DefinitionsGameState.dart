import 'package:english_learning_app/view/DefinitionsGame/DefinitionQuizState.dart';
import 'package:english_learning_app/viewmodel/DefinitionsGame.dart';
import 'package:english_learning_app/viewmodel/TotalPoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:english_learning_app/db/Database.dart';

import 'Result.dart';

class DefinitionsGameState extends State<DefinitionsGame> {
  List<Map<String, Object>> _questions;
  var _questionIndex = 0;
  var _totalScore = 0;
  TotalPoints _totalPoints = TotalPoints();
  var _questionsAmount = 5;

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    if (_questionIndex == _questions.length) {
      _totalPoints.set(_totalPoints.get() + _totalScore);
    }
  }

  List<Map<String, Object>> prepQuestionsArray(List<Question> questions) {
    List<Map<String, Object>> ret = new List<Map<String, Object>>();
    for (int i = 0; i < _questionsAmount; i++) {
      var ans = questions[i].answer.split(',');
      List answers = new List<Map<String, Object>>();
      for (int j = 0; j < 8; j+=2) {
        answers.add({'text': ans[j], 'score': int.parse(ans[j+1])});
      }
      ret.add({'definition': questions[i].question, 'answers': answers});
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    TotalPoints totalPoints = TotalPoints();
    if (_questionIndex == 0) {
      List<Exercise> exercises = DataStorage.db.getAllExercises(4);
      List<Question> questions = DataStorage.db.getAllQuestions(exercises[0].dbKey);
      questions.shuffle();
      _questions = prepQuestionsArray(questions);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Match a word to a definition',
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text(totalPoints.formatter.format(totalPoints.get()),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300)),
              Icon(Icons.stars_rounded, size: 32),
              Text(' '),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questionsAmount
            ? DefinitionQuiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              ) //Quiz
            : Result(_totalScore, _questions),
      ), //Padding
    ); //Scaffold
    //MaterialApp
  }
}
