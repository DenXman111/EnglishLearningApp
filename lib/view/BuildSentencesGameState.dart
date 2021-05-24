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
  var _controllers = new List<TextEditingController>();
  var _sentence = new List<String>();

  int _currentField = 0;
  int _currentSentence = 1;
  int N;

  static const scale = 7.2;

  List<String> _getSentence(int num) {
    List<String> s = new List<String>();
    s.add("I");
    for (int i = 1; i < num; i++) s.add("still");
    s.add("love");
    s.add("TCS");
    return s;
  }

  _nextSentence(){
    setState(() {
      _currentSentence += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    TotalPoints totalPoints = TotalPoints();
    _sentence = _getSentence(_currentSentence);
    N = _sentence.length;
    for (int i = 0; i <= N; i++) {
      if (_controllers.length == i) _controllers.add(TextEditingController());
      _controllers[i].text = "";
    }
    _currentField = 0;

    ButtonStyle _wordStyle = ElevatedButton.styleFrom(
        primary: Colors.grey[400], // background
    );


    List<Widget> _getFields(){
      List<Widget> fields = List<Widget>();
      fields.add(new Text(" "));
      for(int i = 0; i < N; i++){
        fields.add(new Flexible(
          child: TextField(
            controller: _controllers[i],
          ),
        ));
        fields.add(new Text(" "));
      }
      return fields;
    }

    List<Widget> _getWords(){
      List<Widget> words = List<Widget>();

      for(int i = 0; i < N; i++) {
        words.add(new ElevatedButton(
            child: new Text(_sentence[i]),
            style: _wordStyle,
            onPressed: () {
              _controllers[_currentField].text = _sentence[i];
              if (_currentField < N) ++_currentField;
            })
        );
      }
      return words;
    }

    void _clearFields() {
      for (int i = 0; i < N; i++) _controllers[i].text = "";
      _currentField = 0;
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
              children: _getFields(),
            ),

            ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: _getWords(),
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
                  onPressed: _clearFields,
                ),
                ElevatedButton(
                  child: new Text('check'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    //onPrimary: Colors.white, // foreground
                  ),
                  onPressed: (){
                    String msg;
                    var f = true;
                    for (int i = 0; i < N; i++) if (_controllers[i].text != _sentence[i]) f = false;
                    if (f) msg = "Correct"; else msg = "Wrong";

                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(msg),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => {
                                _nextSentence(),
                                Navigator.pop(context)
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    /*
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                      _buildPopupDialog(context, msg),
                    ).then((value) => Navigator.pop(context));*/
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
