import 'package:english_learning_app/db/GameModel.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:hive/hive.dart';
import 'DBInitialization.dart';
import 'QuestionModel.dart';
import 'package:hive_flutter/hive_flutter.dart';


class DataStorage {

  DataStorage._();

  static final DataStorage db = DataStorage._();

  Box games;
  Box exercises;
  Box questions;
  Box special;

  bool init = false;

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
        await questions.deleteAll(questions.keys);
        await games.deleteAll(games.keys);
        await special.deleteAll(special.keys);
        await exercises.deleteAll(exercises.keys);
        DBResetData();
    }
  }

  void storeGame(Game game) {
    db.games.put(game.dbKey, game);
    game.save();
  }

  void storeExercise(Exercise exercise)  {
    db.exercises.put(exercise.dbKey, exercise);
    exercise.save();
    Game game = db.games.get(exercise.gameKey);

    var secondList = game.exerciseKeys.map((item) => String.fromEnvironment(item)).toList();
    secondList.add(exercise.dbKey);
    game.exerciseKeys = secondList;
    game.save();
  }

  void storeQuestion(Question question) {
    db.questions.put(question.dbKey, question);
    question.save();

    Exercise exercise = db.exercises.get(question.exerciseKey);
    var secondList = exercise.questions;
    secondList.add(question);


    exercise.questions = secondList;
    exercise.save();
  }

  List<Game> getAllGames() {
    List<Game> list = db.games.isNotEmpty ? db.games.values.toList().cast<Game>() : [];
    return list;
  }

  List<Exercise> getAllExercises(int gameId) {
    List<Exercise> list = db.exercises.isNotEmpty ? db.exercises.values.toList().cast<Exercise>() : [];
    return list.where((f) => f.gameKey == gameId).toList();
  }

  List<Question> getAllQuestions(String exerciseKey) {
    List<Question> list = db.questions.isNotEmpty ? db.questions.values.toList().cast<Question>() : [];
    return list.where((f) => f.exerciseKey == exerciseKey).toList();
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

  int getTotalPoints() {
    return special.get("points_sum");
  }
  void setTotalPoints(int points){
    special.put("points_sum", points);
  }
}
