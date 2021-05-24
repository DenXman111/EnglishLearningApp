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
  @override
  Widget build(BuildContext context) {
    List<Game> data = DataStorage.db.getAllGames();

    TotalPoints totalPoints = new TotalPoints();

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
              Text(totalPoints.formatter.format(totalPoints.get()),
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
            children: <Widget>[
              TextButton(
                child: Text(
                  data[0].title,
                  style: GoogleFonts.quicksand(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.all(16.0),
                  //backgroundColor: Colors.grey,
                  //onSurface: Colors.white,
                ),
                onPressed: () {
                  print(data[0].description);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DictionaryGame()),
                  );
                },
              ),
              SizedBox(height: 25),
              TextButton(
                child: Text(
                  data[1].title,
                  style: GoogleFonts.quicksand(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.all(16.0),
                  //backgroundColor: Colors.grey,
                  //onSurface: Colors.white,
                ),
                onPressed: () {
                  print(data[1].description);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SynsAntonymsGamePage()),
                  );
                },
              ),
              SizedBox(height: 25),
              TextButton(
                child: Text(
                  data[2].title,
                  style: GoogleFonts.quicksand(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.all(16.0),
                  //backgroundColor: Colors.grey,
                  //onSurface: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuildSentencesGame(),
                    ),
                  );
                },
              ),
              SizedBox(height: 25),
              TextButton(
                child: Text(
                  data[4].title,
                  style: GoogleFonts.quicksand(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.all(16.0),
                  //backgroundColor: Colors.grey,
                  //onSurface: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(data[4]),
                    ),
                  );
                },
              ),
              SizedBox(height: 25),
              TextButton(
                child: Text(
                  data[5].title,
                  style: GoogleFonts.quicksand(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.all(16.0),
                  //backgroundColor: Colors.grey,
                  //onSurface: Colors.white,
                ),
                onPressed: () {
                  print(data[5].description);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PastParticipleGame()),
                  );
                },
              ),
              SizedBox(height: 25),
              TextButton(
                child: Text(
                  "Definitions",
                  style: GoogleFonts.quicksand(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.all(16.0),
                  //backgroundColor: Colors.grey,
                  //onSurface: Colors.white,
                ),
                onPressed: () {
                  // TODO  print("dodac do bazy");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DefinitionsGame()),
                  );
                },
              ),
              SizedBox(height: 25),
              TextButton(
                child: Text(
                  'Settings',
                  style: GoogleFonts.quicksand(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.deepOrange,
                  padding: EdgeInsets.all(16.0),
                  //backgroundColor: Colors.grey,
                  //onSurface: Colors.white,
                ),
                onPressed: () {
                  print('Settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
