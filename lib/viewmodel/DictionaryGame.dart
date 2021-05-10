import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/DictionaryGameState.dart';

class DictionaryGame extends StatefulWidget {
  static String routeName = "/";
  int questionsAmount;


  @override
  State<StatefulWidget> createState() => DictionaryGameState();


}