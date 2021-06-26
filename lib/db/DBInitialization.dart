import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:english_learning_app/resources/GapFillingGameSetup.dart';
import 'package:english_learning_app/resources/SynonymsAndAntonymsGameSetup.dart';
import 'package:english_learning_app/resources/PastParticipleGameSetup.dart';
import 'package:english_learning_app/resources/DefinitionsGameSetup.dart';

import 'Database.dart';
import 'ExerciseModel.dart';
import 'GameModel.dart';
import 'SetUpData.dart';


DBResetData() async {
    /* Add all games  */

  gamesSetUpData.forEach((element) {
    DataStorage.db.storeGame(Game.fromMap(element));
  });


  gapFillingSetUpData.forEach((element) {
    DataStorage.db.storeExercise(Exercise.fromMap(element));
  });

  specialValsSetUpData.forEach((key, value) {
    DataStorage.db.special.put(key, value);
  });

  // Fill Game 5 exercises
  gapFillingQuestions.forEach((element) {
    DataStorage.db.storeQuestion(Question.fromMap(element));
  });

  // Synonyms & Antonyms games
  synAntSetUpExercise.forEach((element) {
    DataStorage.db.storeExercise(Exercise.fromMap(element));
  });

  int id = 1;
  synAntSetUpQuestions.forEach((element) {
    Map<String, dynamic> question = new Map();
    question["question"] = element["word"];

    List<String> syns = element["synonyms"];
    List<String> anto = element["antonyms"];

    String answerString = "S:";
    syns.forEach((element) {
      if (element != "") {
        answerString += element + " , ";
      }
    });

    answerString += "| A: ";
    anto.forEach((element) {
      if (element != "") {
        answerString += element + " , ";
      }
    });
    question["answer"] = answerString;
    question["exercise_key"] = synAntSetUpExercise[0]["exercise_id"];
    question["question_id"] = id;
    id++;
    DataStorage.db.storeQuestion(Question.fromMap(question));
  });

  pastParticipleSetUpExercise.forEach((element) {
    DataStorage.db.storeExercise(Exercise.fromMap(element));
  });

  pastParticipleSetUpQuestions.forEach((element) {
    DataStorage.db.storeQuestion(Question.fromMap(element));
  });

  definitionsSetUpExercise.forEach((element) {
    DataStorage.db.storeExercise(Exercise.fromMap(element));
  });

  definitionsSetUpQuestions.forEach((element) {
    DataStorage.db.storeQuestion(Question.fromMap(element));
  });
}