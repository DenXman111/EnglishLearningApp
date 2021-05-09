import 'package:english_learning_app/viewmodel/AnswerWidget.dart';
import 'package:flutter/material.dart';

import 'Question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    print("build");
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'],
        ), //Question
        Answer(
                () => answerQuestion(1), questions[questionIndex]['answers'])
      ],
    ); //Column
  }
}