import 'package:english_learning_app/db/Database.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:english_learning_app/viewmodel/ExercisePage.dart';
import 'package:english_learning_app/viewmodel/GamePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodel/TotalPoints.dart';

class GamePageState extends State<GamePage>{

  int gameKey;
  GamePageState(this.gameKey);

  @override
  Widget build(BuildContext context) {
    List<Exercise> exercises = DataStorage.db.getAllExercises(this.gameKey);
    TotalPoints totalPoints = new TotalPoints();
    List<TextButton> buttonsList = new List<TextButton>();


    List<Widget> _buildButtonsWithNames() {
      for (int i = 0; i < exercises.length; i++) {
        buttonsList
            .add(new TextButton(
                    child: Text(
                      "Exercise " + exercises[i].dbKey.toString(),
                      style: GoogleFonts.quicksand(
                        fontSize: 48,
                        fontWeight: FontWeight.w400,
                      ),

                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.deepOrange,
                      padding: EdgeInsets.all(16.0),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExercisePage( exercises[i].dbKey),
                        ),
                        //    argumne
                      );
                    },
        ),);
      }
      return buttonsList;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filling gaps game',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildButtonsWithNames()
        ),
      ),
    );
  }
}
