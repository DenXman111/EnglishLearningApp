import 'package:hive/hive.dart';

part 'GameModel.g.dart';

@HiveType(typeId: 10)
class Game extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String storageType; // todo: replace with some enum?

  @HiveField(3)
  String description;

  @HiveField(4)
  List<int> exerciseKeys;

  Game({
    this.id,
    this.title,
    this.storageType,
    this.description,
    this.exerciseKeys
  });

  factory Game.fromMap(Map<String, dynamic> json) => new Game(
    id: json["id"],
    title: json["title"],
    storageType: json["storage_type"],
    description: json["description"],
    exerciseKeys: json["exercise_keys"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "storageType": storageType,
    "description": description,
    "exercise_keys": exerciseKeys,
  };
}
