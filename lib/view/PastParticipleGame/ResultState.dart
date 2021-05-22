import 'package:english_learning_app/viewmodel/MenuPage.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  var questions;
  var correctAnswers;

  Result(this.resultScore, this.questions, this.correctAnswers);

  String get resultPhrase {
    String resultText;
    if (resultScore >= 9) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 7) {
      resultText = 'It is a good score.';
      print(resultScore);
    } else if (resultScore >= 5) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 3) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  List<Widget> displayResult(var question, var answers) {
    List<Widget> res = new List<Widget>();
    for (int i = 0; i < answers.length; i++) {
      res.add(new Text(questions[i]['questionText']));
      for (int j = 0; j < 2; ++j) {
        Color c = answers[i][j] == 1 ? Colors.green : Colors.red;
        res.add(new Text(
          questions[i]['answers'][j],
          style: TextStyle(color: c),
        ));
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    print(resultScore);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Text
          Text(
            'Score ' '$resultScore',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Text
          ElevatedButton(
              child: Text(
                'Go back to main screen',
              ), //Text
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              }),
          ElevatedButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Results'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: displayResult(questions, correctAnswers),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Text('Show Dialog'),
          ) //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
