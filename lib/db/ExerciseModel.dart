
import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'ExerciseModel.g.dart';

@HiveType(typeId: 2)
class Exercise extends HiveObject {
  @HiveField(0)
  int gameKey;

  @HiveField(1)
  /* Note: this can't be changed to set, because Hive doesn't like it */
  List<Question> questions;

  @HiveField(2)
  String dbKey;

  @HiveField(3)
  String description;

  Exercise({
    this.gameKey,
    this.dbKey,
    this.description,
  }){
    this.questions = [];
  }


  factory Exercise.fromMap(Map<String, dynamic> json) => new Exercise(
      gameKey: json["game_key"],
      dbKey: json["exercise_id"],
      description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "game_key": gameKey,
    "description": description
  };

}