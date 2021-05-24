import 'package:english_learning_app/viewmodel/MenuPage.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;

  Result(this.resultScore);

  //Remark Logic
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
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Results'),
               /* content: SingleChildScrollView(
                  child: ListBody(
                    children: displayResult(questions, correctAnswers),
                  ),
                ),*/
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