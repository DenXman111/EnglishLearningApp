import 'package:english_learning_app/db/GameModel.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:hive/hive.dart';
import 'QuestionModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'SetUpData.dart';

class DataStorage {

  DataStorage._();

  static final DataStorage db = DataStorage._();

  Box games;
  Box exercises;
  Box questions;
  Box special;

  bool init = false;

  DBResetData() async {
    gamesSetUpData.forEach((element) {
      DataStorage.db.newGame(Game.fromMap(element));
    });

    specialValsSetUpData.forEach((key, value) {
      special.put(key, value);
    });

  }

  DBInit(bool reset) async {
    await Hive.initFlutter();
    Hive.registerAdapter(QuestionAdapter());
    Hive.registerAdapter(ExerciseAdapter());
    Hive.registerAdapter(GameAdapter());

    questions = await Hive.openBox('QuestionStore');
    exercises = await Hive.openBox('ExerciseStore');
    games = await Hive.openBox('GameStore');
    special = await Hive.openBox('Special');

    if (reset) {
        DBResetData();
    }
  }

  int newGame(Game game) {
    game.dbKey = db.games.length;
    db.games.put(db.games.length, game);
    game.save();
    return db.games.length - 1;
  }

  int newExercise(Exercise exercise)  {
    exercise.dbKey = db.exercises.length;
    db.exercises.put(db.exercises.length, exercise);
    exercise.save();

    Game game = db.games.get(exercise.gameKey);
    game.exerciseKeys.add(db.exercises.length - 1);
    game.save();

    return db.exercises.length - 1;
  }

  int newQuestion(Question question) {
    question.dbKey = db.questions.length;
    db.questions.put(db.questions.length, question);
    question.save();

    Exercise exercise = db.games.get(question.exerciseKey);
    exercise.questionKeys.add(db.exercises.length - 1);
    exercise.save();

    return db.questions.length - 1;
  }

  List<Game> getAllGames() {
    List<Game> list = db.games.isNotEmpty ? db.games.values.toList().cast<Game>() : [];
    return list;
  }

  List<Exercise> getAllExercises(int gameId) {
    List<Exercise> list = db.exercises.isNotEmpty ? db.exercises.values.toList().cast<Exercise>() : [];
    return list.where((f) => f.gameKey == gameId).toList();
  }

  List<Question> getAllQuestions(int exerciseId) {
    List<Question> list = db.questions.isNotEmpty ? db.questions.values.toList().cast<Question>() : [];
    return list.where((f) => f.exerciseKey == exerciseId).toList();
  }

  bool setPoint(Question question) {
    if (question.pointObtained) {
      return false;
    }

    question.pointObtained = true;
    question.pointObtainTime = DateTime.now();
    question.save();
    special.put("points_sum", special.get("points_sum") + 1);

    return true;
  }

  int totalAmountOfPoints() {
    return special.get("points_sum");
  }

}
