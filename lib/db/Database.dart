import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:english_learning_app/db/GameModel.dart';
import 'package:english_learning_app/db/ExerciseModel.dart';
import 'package:sqflite/sqflite.dart';

import 'QuestionModel.dart';

/*
    Based on: https://github.com/Rahiche/sqlite_demo
*/

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "EnglishLearningApp.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {});

    await db.execute("CREATE TABLE IF NOT EXISTS Games ("
        "id           INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title        TEXT,"
        "description  TEXT,"
        "storage_type TEXT"
        ")");

    await db.execute("CREATE TABLE IF NOT EXISTS Exercises ("
        "id       INTEGER PRIMARY KEY AUTOINCREMENT,"
        "game_id  INTEGER,"
        "FOREIGN KEY(game_id) REFERENCES Exercises(id)"
        ")");

    await db.execute("CREATE TABLE IF NOT EXISTS Questions ("
        "id                 INTEGER PRIMARY KEY AUTOINCREMENT,"
        "exercise_id        INTEGER,"
        "point_obtained     BOOLEAN ,"
        "point_obtain_time  DATETIME,"
        "question           TEXT,"
        "answer             TEXT,"
        "FOREIGN KEY(exercise_id) REFERENCES Exercises(id)"
        ")");
    return db;
  }

  newGame(Game newGame) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT INTO Games (title, description, storage_type) VALUES (?,?,?)",
        [newGame.title, newGame.description, newGame.storageType]);
    return raw;
  }

  newExercise(Exercise exercise) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT INTO Exercises (game_id) VALUES (?,?)",
        [exercise.gameId]);
    return raw;
  }
  
  newQuestion(Question question) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT INTO Questions "
            "(exercise_id, point_obtained, point_obtain_time, question, answer) VALUES (?, FALSE, NULL, ?, ?)",
        [question.exerciseId, question.question, question.answer]);
    return raw;
  }


  pointGained(int questionId) async {
    final db = await database;
    // TODO: will DateTime.now() work???
    // todo: test this check
    var pointObtained = await db.rawQuery(
        "SELECT point_obtained FROM Questions WHERE id = ?", [questionId]);
    if (pointObtained.first['point_obtained'] == false) {
      return;
    }

    var raw = await db.rawInsert(
        "UPDATE Questions "
            "SET point_obtained = TRUE, point_obtain_time = ? "
            "WHERE id = ?",
        [DateTime.now(), questionId]);
    return raw;
  }


  Future<List<Game>> getAllGames() async {
    final db = await database;
    var res = await db.query("Games");
    List<Game> list =
    res.isNotEmpty ? res.map((c) => Game.fromMap(c)).toList() : [];
    return list;
  }


  Future<List<Exercise>> getAllExercises(int gameId) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM Exercises WHERE id = ?", [gameId]);
    List<Exercise> list =
    res.isNotEmpty ? res.map((c) => Exercise.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Question>> getAllQuestions(int exerciseId) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM Questions WHERE id = ?", [exerciseId]);
    List<Question> list =
    res.isNotEmpty ? res.map((c) => Question.fromMap(c)).toList() : [];
    return list;
  }


  bool checkAnswer(String answer) {
    // TODO: check is based on check type: API etc - to discuss
    throw UnimplementedError();
  }


}
