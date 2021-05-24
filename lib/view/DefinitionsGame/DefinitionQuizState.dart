import 'package:english_learning_app/view/DefinitionsGame/Definition.dart';
import 'package:flutter/material.dart';

import './Answer.dart';
import './Definition.dart';

class DefinitionQuiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  DefinitionQuiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Definition(
          questions[questionIndex]['definition'],
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']);
        }).toList()
      ],
    ); //Column
  }
}