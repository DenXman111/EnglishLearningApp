import 'package:english_learning_app/viewmodel/AnswerWidget.dart';
import 'package:flutter/material.dart';


class FormPastParticipleGame extends State<Answer> {

  FormPastParticipleGame(this.incereaseIndex, this.answerText);

  final Function incereaseIndex;
  final List<String> answerText;
  final _formKey = GlobalKey<FormState>();
  final pastSimpleController = TextEditingController();
  final pastParticipleController = TextEditingController();

  int awardPoints() {
    int score = 0;
    print(pastSimpleController.text.toLowerCase());
    print(answerText);
    print("sdsfd");
    if (pastSimpleController.text.toLowerCase() == answerText[0].toLowerCase()) {
      score += 1;
    }
    if (pastParticipleController.text.toLowerCase() == answerText[1].toLowerCase()) {
      score += 1;
    }
    return score;
  }

  String _verbValidation(String verb) {
  if (verb == null || verb.isEmpty) {
  return 'Complete the field.';
  }
  return RegExp(r"^[a-zA-Z]+$").hasMatch(verb)
  ? null
      : 'Do not use anything other than letters.';
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Container(
  width: double.infinity,

  child: Form(
  key: _formKey,
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[

  Padding(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  child: TextFormField(
    controller: pastSimpleController,
  decoration: InputDecoration(
  border: UnderlineInputBorder(),
  labelText: 'Past Simple',
  ),
  validator: (String value) {
  return _verbValidation(value);
  },
  ),
  ),
  Padding(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  child: TextFormField(
    controller: pastParticipleController,
  decoration: InputDecoration(
  border: UnderlineInputBorder(),
  labelText: 'Past Participle',
  ),
  validator: (String value) {
  return _verbValidation(value);
  },
  ),
  ),
  Padding(
  padding: const EdgeInsets.symmetric(vertical: 16.0),
  child: ElevatedButton(
  onPressed: () {
  print(awardPoints());
  _formKey.currentState.reset();
  incereaseIndex();
  },
  child: Text('Next'),
  ),
  ),
  ] //RaisedButton
  )
  )
  );//Container
  }
  }
