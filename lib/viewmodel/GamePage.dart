import 'package:english_learning_app/db/GameModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/GamePageState.dart';

class GamePage extends StatefulWidget {
  static String routeName = "/";

  Game game;
  GamePage(this.game);

  @override
  State<StatefulWidget> createState() {
    return GamePageState(this.game);
  }
}

