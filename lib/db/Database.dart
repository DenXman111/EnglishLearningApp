import 'dart:async';
import 'dart:io';

import 'package:english_learning_app/db/GameModel.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:hive/hive.dart';
import 'QuestionModel.dart';

class DataStorage {

  int ctr = 0;
  DataStorage._();

  static final DataStorage db = DataStorage._();

  Box games;
  Box exercises;
  Box questions;

  bool init = false;

  DBInit() async {
    questions = await Hive.openBox('QuestionStore');
    exercises = await Hive.openBox('ExerciseStore');
    games = await Hive.openBox('GameStore');
  }

  int newGame(Game game) {
    db.games.put(ctr, game);
    game.save();
    ctr++;      // TODO: FIX COUNTER, it's horrible
    return ctr - 1;
  }

  int newExercise(Exercise exercise)  {
    db.games.put(ctr, exercise);
    exercise.save();
    ctr++;      // TODO: FIX COUNTER, it's horrible
    return ctr - 1;
  }

  int newQuestion(Question question) {
    db.questions.put(ctr, question);
    question.save();
    ctr++;
    return ctr - 1;
  }

  List<Game> getAllGames() {
    List<Game> list = db.games.isNotEmpty ? db.games.values.toList().cast<Game>() : [];
    return list;
  }

  Future<List<Exercise>> getAllExercises(int gameId) async {
    List<Exercise> list = db.exercises.isNotEmpty ? db.exercises.values.toList().cast<Exercise>() : [];
    return list;
  }

  Future<List<Question>> getAllQuestions(int exerciseId) async {
    List<Question> list = db.questions.isNotEmpty ? db.questions.values.toList().cast<Question>() : [];
    return list;
  }

}
