import 'package:hive/hive.dart';

part 'ExerciseModel.g.dart';

@HiveType(typeId: 2)
class Exercise extends HiveObject {
  @HiveField(0)
  int gameKey;

  @HiveField(1)
  List<int> questionKeys;

  @HiveField(2)
  int dbKey;

  Exercise({
    this.gameKey,
    this.questionKeys
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => new Exercise(
      gameKey: json["game_key"],
      questionKeys: json["question_keys"]
  );

  Map<String, dynamic> toMap() => {
    "game_key": gameKey,
    "question_keys": questionKeys,
  };

}