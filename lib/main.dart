import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/Database.dart';
import 'db/ExerciseModel.dart';
import 'db/QuestionModel.dart';
import 'db/GameModel.dart';
import 'db/SetUpData.dart';
import 'viewmodels/MenuPage.dart';

void main() async{
  await Hive.initFlutter();
  await DataStorage.db.DBInit();
  await Hive.openBox('example_db');
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(GameAdapter());
  // TODO: move setup into DataStorage class
  DataStorage.db.newGame(Game.fromMap(setUpData[0]));
  DataStorage.db.newGame(Game.fromMap(setUpData[1]));
  DataStorage.db.newGame(Game.fromMap(setUpData[2]));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English learning',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo.shade900,
      ),
      routes: {
        MenuPage.routeName : (context) => MenuPage(),
        //TODO Create other pages and paste their routeName's here
      },
      initialRoute: MenuPage.routeName,
    );
  }
}