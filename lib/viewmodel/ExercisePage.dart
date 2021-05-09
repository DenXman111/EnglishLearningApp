import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/GapFillingExerciseState.dart';

class ExercisePage extends StatefulWidget {
  static String routeName = "/";

  String exerciseKey;
  ExercisePage(this.exerciseKey);

  @override
  State<StatefulWidget> createState() {
    return GapFillingExercisePageState(this.exerciseKey);
  }
}
