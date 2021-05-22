import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../viewmodel/TotalPoints.dart';
import '../../viewmodel/PastParticipleGameWidget.dart';
import 'QuizState.dart';
import 'ResultState.dart';

class PastParticipleGameState extends State<PastParticipleGame> {
  final _questions = const [
    {
      'questionText': '1/5 hit',
      'answers': ['hit', 'hit'],
    },
    {
      'questionText': '2/5 sing',
      'answers': ['sang', 'sung'],
    },
    {
      'questionText': '3/5  go',
      'answers': ['went', 'gone'],
    },
    {
      'questionText': '4/5 throw',
      'answers': ['threw', 'thrown'],
    },
    {
      'questionText': '5/5 do',
      'answers': ['did', 'done'],
    },
  ];

  var _questionIndex = 0;
  int pointsBeforeGame = 0;
  var _correctAnswers = [[0,0],[0,0],[0,0],[0,0],[0,0]];

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    TotalPoints totalPoints = TotalPoints();
    if (_questionIndex == 0) {
      pointsBeforeGame = totalPoints.get();
    }
    return MaterialApp(
        home: Scaffold(
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
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: _questionIndex < _questions.length
                  ? Quiz(
                      answerQuestion: _answerQuestion,
                      questionIndex: _questionIndex,
                      questions: _questions,
                      correctAnswers: _correctAnswers,
                    )
                  : Result(totalPoints.get()-pointsBeforeGame, _questions, _correctAnswers),
            )));
  }
}
