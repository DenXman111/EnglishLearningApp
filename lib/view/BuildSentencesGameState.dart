import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/viewmodel/BuildSentencesGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodel/TotalPoints.dart';

enum VerificationResult {
  CORRECT,
  INCORRECT
}


class BuildSentencesGameState extends State<BuildSentencesGame>{
  var txt1 = TextEditingController();
  static const scale = 7.2;

  @override
  Widget build(BuildContext context) {
    TotalPoints totalPoints = TotalPoints();

    ButtonStyle _wordStyle = ElevatedButton.styleFrom(
        primary: Colors.grey[400], // background
    );

    Widget _buildPopupDialog(BuildContext context, String text) {
      return new AlertDialog(
        title: Text(text),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Build sentences",
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          Row(
            children: <Widget> [
              Text(totalPoints.formatter.format(totalPoints.get()), style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w300)),
              Icon(Icons.stars_rounded, size: 32),
              Text(' '),
            ],
          ),
        ],
      ),



      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: txt1,
                  ),
                ),
                Text(" "),
                Flexible(
                  child: TextField(

                  ),
                ),
                Text(" "),
                Flexible(
                  child: TextField(

                  ),
                ),
              ],
            ),

            ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    child: new Text('am'),
                    style: _wordStyle,
                    onPressed: (){ txt1.text = "am";},
                  ),
                  ElevatedButton(
                    child: new Text('Denis'),
                    style: _wordStyle,
                    onPressed: (){ txt1.text = "Denis";},
                  ),
                  ElevatedButton(
                    child: new Text('I'),
                    style: _wordStyle,
                    onPressed: (){ txt1.text = "I";},
                  ),
                ],
              ),

            ButtonBar(
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  child: new Text('clear'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: (){ txt1.text = "";},
                ),
                ElevatedButton(
                  child: new Text('check'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    //onPrimary: Colors.white, // foreground
                  ),
                  onPressed: (){
                    String msg;
                    if (txt1.text == "I"){
                      msg = "Correct";
                    } else{
                      msg = "Wrong";
                    }
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildPopupDialog(context, msg),
                    ).then((value) => Navigator.pop(context));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
