

class Exercise {
  int id;
  int gameId;

  Exercise({
    this.id,
    this.gameId
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => new Exercise(
    id: json["id"],
    gameId: json["game_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "gameId": gameId,
  };

}