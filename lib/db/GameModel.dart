import 'dart:convert';

/*
    Based on: https://github.com/Rahiche/sqlite_demo
*/

Game clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Game.fromMap(jsonData);
}

String clientToJson(Game data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Game {
  int id;
  String title;
  String storageType; // todo: replace with some enum?
  String description;

  Game({
    this.id,
    this.title,
    this.storageType,
    this.description,
  });

  factory Game.fromMap(Map<String, dynamic> json) => new Game(
    id: json["id"],
    title: json["title"],
    storageType: json["storage_type"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "storageType": storageType,
    "description": description,
  };
}
