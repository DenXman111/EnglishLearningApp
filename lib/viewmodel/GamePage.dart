import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/GamePageState.dart';

class GamePage extends StatefulWidget {
  static String routeName = "/";

  int gameKey;
  GamePage(this.gameKey);

  @override
  State<StatefulWidget> createState() {
    return GamePageState(this.gameKey);
  }
}

