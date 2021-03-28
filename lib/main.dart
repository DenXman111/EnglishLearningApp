import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'viewmodels/MenuPage.dart';

void main() => runApp(MyApp());

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