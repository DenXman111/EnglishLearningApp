import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db/Database.dart';
import 'viewmodel/MenuPage.dart';

void main() async{
  bool reset = false;
  await DataStorage.db.DBInit(reset);
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
      },
      initialRoute: MenuPage.routeName,
    );
  }
}