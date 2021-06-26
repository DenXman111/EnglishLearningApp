import 'dart:async';
import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/db/GameModel.dart';
import 'package:english_learning_app/viewmodel/DefinitionsGame.dart';
import 'package:english_learning_app/viewmodel/PastParticipleGameWidget.dart';
import 'package:english_learning_app/viewmodel/DictionaryGame.dart';
import 'package:english_learning_app/viewmodel/BuildSentencesGame.dart';
import 'package:english_learning_app/viewmodel/MenuPage.dart';
import 'package:english_learning_app/viewmodel/GamePage.dart';
import 'package:english_learning_app/viewmodel/SynsAntonymsGamePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodel/TotalPoints.dart';

class MenuPageState extends State<MenuPage> {
  int tp;
  TotalPoints totalPoints = new TotalPoints();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _refreshPoints());
  }

  void _refreshPoints() {
    if (mounted) {
      setState(() {
        tp = totalPoints.get();
      });
    }
  }

  List<Widget> buttons() {
    List<Game> data = DataStorage.db.getAllGames();

    List<String> titles = [data[0].title, data[1].title, data[2].title, data[4].title, data[5].title, "Definitions"];
    List classes = [DictionaryGame(), SynsAntonymsGamePage(), BuildSentencesGame(), GamePage(data[4]), PastParticipleGame(), DefinitionsGame()];

    List<Widget> buttonList = [];

    for (int i = 0; i < titles.length; i++) {
      buttonList.add(TextButton(
        child: Text(
          titles[i],
          style: GoogleFonts.quicksand(
            fontSize: 48,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        style: TextButton.styleFrom(
          primary: Colors.deepOrange,
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => classes[i]
            ),
          );
        },
      ),);
      buttonList.add(SizedBox(height: 25));
    }
    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'English learning',
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text('$tp',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300)),
              Icon(Icons.stars_rounded, size: 32),
              Text(' '),
            ],
          ),
        ],
      ),
      body: Center(
        child: new SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons()
          ),
        ),
      ),
    );
  }
}
