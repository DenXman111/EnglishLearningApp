import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/viewmodel/BuildSentencesGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../viewmodel/TotalPoints.dart';

class BuildSentencesGameState extends State<BuildSentencesGame>{
  var obj = ["TCS", "door", "man", "student", "happy meal"];
  var subj = ["I", "killer", "car", "cat", "black dog"];
  var verb = ["kill", "love", "product", "pass", "go to"];
  var tense = ["present", "past", "future"];

  var _controllers = new List<TextEditingController>();
  var _sentence = new List<String>();
  var _shuffledSentence = new List<String>();
  var rng = new Random();
  String _sentenceString;

  final String _token = "e6cd28af5amsh621ee8b371a2a13p14a595***";

  int _currentField = 0;
  int _currentSentence = 1;
  int N;

  static const scale = 7.2;

  void _generateSentence() async{
    _sentenceString = null;
    //print("Generating");
    var query = {'object': obj[rng.nextInt(obj.length)],
      'subject': subj[rng.nextInt(subj.length)],
      'verb': verb[rng.nextInt(verb.length)],
      'tense': tense[rng.nextInt(tense.length)]};
    await http.get(Uri.https("linguatools-sentence-generating.p.rapidapi.com", "/realise", query),
        headers: { "x-rapidapi-key": _token,
        "x-rapidapi-host": "linguatools-sentence-generating.p.rapidapi.com"}).then((response){

      _sentenceString = json.decode(response.body)["sentence"];
      //print(json.decode(response.body)["sentence"]);
      //print(_sentenceString);
    });

  }
  void shuffle(List items) {
    var random = new Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var t = items[i];
      items[i] = items[n];
      items[n] = t;
    }

  }

  List<String> _getSentence(int num){
    List<String> s = new List<String>();
    if (_sentenceString == null) {
      s.add("I");
      for (int i = 1; i < num; i++) s.add("still");
      s.add("love");
      s.add("TCS");
    } else{
      RegExp r = RegExp(r"(\S+)([\s]+|$)");
      var matches = r.allMatches(_sentenceString);
      matches.toList().asMap().forEach((i, m) => s.add(m.group(1)));
      _generateSentence();
    }

    return s;
  }

  _nextSentence(){
    setState(() {
      _currentSentence += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentSentence == 1) _generateSentence();
    TotalPoints totalPoints = TotalPoints();

    _sentence = _getSentence(_currentSentence);
    _shuffledSentence = new List<String>.from(_sentence);
    shuffle(_shuffledSentence);

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
            child: new Text(_shuffledSentence[i]),
            style: _wordStyle,
            onPressed: () {
              _controllers[_currentField].text = _shuffledSentence[i];
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
                    if (f) totalPoints.set(totalPoints.get() + 1);

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
