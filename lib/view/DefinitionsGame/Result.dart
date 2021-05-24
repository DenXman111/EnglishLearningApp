import 'package:english_learning_app/viewmodel/MenuPage.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  var questions;

  Result(this.resultScore, this.questions);

  String get resultPhrase {
    String resultText;
    if (resultScore >= 5) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 4) {
      resultText = 'Good enough!';
      print(resultScore);
    } else if (resultScore >= 3) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 2) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  List<Widget> displayResult(var question) {
    List<Widget> res = new List<Widget>();
    for (int i = 0; i < questions.length; ++i) {
      res.add(new Text(questions[i]['definition']));
      var answer = questions[i]['answers'];
        for (int j = 0; j < 4; ++j) {
          if (answer[j]['score'] == 1) {
            res.add(new Text(" - " + answer[j]['text']));
          }
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () =>
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        title: const Text('Correct answers'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: displayResult(questions),
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
            child: const Text('See correct answers'),
          ) //FlatButton
        ], //FlatButton
        //<Widget>[]
      ), //Column
    ); //Center
  }
}
