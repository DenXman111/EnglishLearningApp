

class Question {
  int id;
  int exerciseId;
  bool pointObtained;
  DateTime pointObtainTime;
  String question;
  String answer;


  Question({
    this.id,
    this.exerciseId,
    this.pointObtained,
    this.pointObtainTime,
    this.question,
    this.answer
  });

  factory Question.fromMap(Map<String, dynamic> json) => new Question (
    id: json["id"],
    exerciseId: json["exercise_id"],
    pointObtained: json["point_obtained"],
    pointObtainTime: json["point_obtain_time"],
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "exerciseId": exerciseId,
    "pointObtained": pointObtained,
    "pointObtainTime": pointObtainTime,
    "question": question,
    "answer": answer,
  };

}