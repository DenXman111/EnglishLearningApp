import 'package:hive/hive.dart';

part 'GameModel.g.dart';

@HiveType(typeId: 10)
class Game extends HiveObject {

  @HiveField(0)
  int dbKey;

  @HiveField(1)
  String title;

  @HiveField(2)
  String storageType; // todo: replace with some enum?

  @HiveField(3)
  String description;

  @HiveField(4)
  /* Note: this can't be changed to set, because Hive doesn't like it */
  List<String> exerciseKeys;

  Game({
    this.dbKey,
    this.title,
    this.storageType,
    this.description,
    this.exerciseKeys,
  }) {

    // if (this.exerciseKeys == null)
    //   this.exerciseKeys = List<String>();
  }

  factory Game.fromMap(Map<String, dynamic> json) => new Game(
    dbKey: json["id"],
    title: json["title"],
    storageType: json["storageType"],
    description: json["description"],
    exerciseKeys: json["exerciseKeys"].cast<String>(),
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "storageType": storageType,
    "description": description,
    "exercise_keys": exerciseKeys,
  };
}
