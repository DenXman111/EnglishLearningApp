import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../viewmodel/PastParticipleGameWidget.dart';
import 'QuizState.dart';
import 'ResultState.dart';

class PastParticipleGameState extends State<PastParticipleGame> {
  final _questions = const [
    {
      'questionText': '1/5 hit',
      'answers': [ 'hit', 'hit'],
    },
    {
      'questionText': '2/5 sing',
      'answers': [ 'sang', 'sung'],
    },
    {
      'questionText': '3/5  go',
      'answers': [ 'went', 'gone'],
    },
    {
      'questionText': '4/5 throw',
      'answers': [ 'threw', 'thrown'],
    },
    {
      'questionText': '5/5 do',
      'answers': [ 'did', 'done'],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Past Participle Game',
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
        body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Quiz(
          answerQuestion: _answerQuestion,
          questionIndex: _questionIndex,
          questions: _questions,
        ) : Result(_totalScore),
      )
    )
    );
  }
}
