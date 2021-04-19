import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodel/PastParticipleGameWidget.dart';

class PastParticipleGameState extends State<PastParticipleGame> {
  final _questions = const [
    {
      'questionText': 'hit',
      'answer1': 'hit',
      'answer2': 'hit',
    },
    {
      'questionText': 'a',
      'answer1': 'a',
      'answer2': 'a',
    },
    {
      'questionText': 'b',
      'answer1': 'd',
      'answer2': 'c',
    }
  ];

  var _questionIndex = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
    });
  }

  void _answerQuestion(int score) {
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

  String _verbValidation(String verb) {
    if (verb == null || verb.isEmpty) {
      return 'Complete the field.';
    }
    return RegExp(r"^[a-zA-Z]+$").hasMatch(verb)
        ? null
        : 'Do not use anything other than letters.';
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Past Participle Game',
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'verb',
                    style: DefaultTextStyle.of(context).style,
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Past Simple',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return _verbValidation(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Past Participle',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return _verbValidation(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Check'),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
