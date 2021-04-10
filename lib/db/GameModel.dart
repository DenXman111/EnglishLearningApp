import 'package:hive/hive.dart';

part 'GameModel.g.dart';

@HiveType(typeId: 10)
class Game extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String storageType; // todo: replace with some enum?

  @HiveField(2)
  String description;

  @HiveField(3)
  List<int> exerciseKeys;

  @HiveField(4)
  int dbKey;

  Game({
    this.title,
    this.storageType,
    this.description,
    this.exerciseKeys
  });

  factory Game.fromMap(Map<String, dynamic> json) => new Game(
    title: json["title"],
    storageType: json["storage_type"],
    description: json["description"],
    exerciseKeys: json["exercise_keys"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "storageType": storageType,
    "description": description,
    "exercise_keys": exerciseKeys,
  };
}
