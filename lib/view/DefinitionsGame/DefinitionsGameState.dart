import 'package:english_learning_app/view/DefinitionsGame/DefinitionQuizState.dart';
import 'package:english_learning_app/viewmodel/DefinitionsGame.dart';
import 'package:english_learning_app/viewmodel/TotalPoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Result.dart';

class DefinitionsGameState extends State<DefinitionsGame> {
  final _questions = const [
    {
      'definition': 'Q1. a state or condition markedly different from the norm',
      'answers': [
        {'text': 'abjure', 'score': 0},
        {'text': 'evanescent', 'score': 0},
        {'text': 'aberration', 'score': 1},
        {'text': 'intimation', 'score': 0},
      ],
    },
    {
      'definition': 'Q2. abusive language used to express blame or censure',
      'answers': [
        {'text': 'ostensible', 'score': 0},
        {'text': 'dirge', 'score': 0},
        {'text': 'clamor', 'score': 0},
        {'text': 'invective', 'score': 1},
      ],
    },
    {
      'definition': ' Q3. transparently clear; easily understandable',
      'answers': [
        {'text': 'vitriolic', 'score': 0},
        {'text': 'pellucid', 'score': 1},
        {'text': 'impinge', 'score': 0},
        {'text': 'equivocal', 'score': 0},
      ],
    },
    {
      'definition': 'Q4. something causing misery or death',
      'answers': [
        {'text': 'bane', 'score': 1},
        {'text': 'adamant', 'score': 0},
        {'text': 'wanton', 'score': 0},
        {'text': 'pernicious', 'score': 0},
      ],
    },
    {
      'definition': 'Q5. conspicuously and outrageously bad or reprehensible',
      'answers': [
        {
          'text': 'emend',
          'score': 0,
        },
        {'text': 'egregious', 'score': 1},
        {'text': 'expunge', 'score': 0},
        {'text': 'onerous', 'score': 0},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;
  TotalPoints _totalPoints = TotalPoints();

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    if (_questionIndex == _questions.length) {
      _totalPoints.set(_totalPoints.get() + _totalScore);
    }
  }

  @override
  Widget build(BuildContext context) {
    TotalPoints totalPoints = TotalPoints();

    return MaterialApp(
      home: Scaffold(
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
          child: _questionIndex < _questions.length
              ? DefinitionQuiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                ) //Quiz
              : Result(_totalScore, _questions),
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}
