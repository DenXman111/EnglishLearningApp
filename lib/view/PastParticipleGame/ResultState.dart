import 'package:english_learning_app/viewmodel/MenuPage.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;

  Result(this.resultScore);

  String get resultPhrase {
    String resultText;
    if (resultScore >= 9) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 7) {
      resultText = 'Pretty likeable!';
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
            }
          ),
            ElevatedButton(
              child: Text(
              'See results',
              ) //Text
             // onPressed: () :

          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
