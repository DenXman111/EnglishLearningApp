import 'package:english_learning_app/db/QuestionModel.dart';
import 'package:english_learning_app/resources/GapFillingGameSetup.dart';

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

}