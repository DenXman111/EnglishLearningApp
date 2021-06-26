import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:english_learning_app/db/QuestionModel.dart';
import '../../viewmodel/TotalPoints.dart';
import '../../viewmodel/PastParticipleGameWidget.dart';
import 'QuizState.dart';
import 'ResultState.dart';

class PastParticipleGameState extends State<PastParticipleGame> {
  List<Map<String, Object>> _questions;
  var _questionIndex = 0;
  var _questionsAmount = 5;
  int pointsBeforeGame = 0;
  var _correctAnswers = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0]
  ];

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  List<Map<String, Object>> prepQuestionsArray(List<Question> questions) {
    List<Map<String, Object>> ret = new List<Map<String, Object>>();
    for (int i = 0; i < _questionsAmount; ++i) {
      var ans = questions[i].answer.split(',');
      ret.add({'questionText': questions[i].question, 'answers': ans});
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    TotalPoints totalPoints = TotalPoints();
    if (_questionIndex == 0) {
      pointsBeforeGame = totalPoints.get();
      List<Exercise> exercises = DataStorage.db.getAllExercises(6);
      List<Question> questions =
          DataStorage.db.getAllQuestions(exercises[0].dbKey);
      questions.shuffle();
      _questions = prepQuestionsArray(questions);
    }
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "Write past form of a verb",
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
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                  correctAnswers: _correctAnswers,
                )
              : Result(totalPoints.get() - pointsBeforeGame, _questions,
                  _correctAnswers),
        ));
  }
}
