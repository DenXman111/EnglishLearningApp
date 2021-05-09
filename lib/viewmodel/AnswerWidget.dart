import 'package:english_learning_app/view/PastParticipleGame/FormPastParticipleGame.dart';
import 'package:flutter/cupertino.dart';

class Answer extends StatefulWidget {
  Answer(this._incereaseIndex, this.answerText);
  final Function _incereaseIndex;
  final List<String> answerText;
  @override
  FormPastParticipleGame createState() => FormPastParticipleGame(_incereaseIndex, answerText);
}