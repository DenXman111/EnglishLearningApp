import 'package:hive/hive.dart';

part 'QuestionModel.g.dart';

@HiveType(typeId: 3)
class Question extends HiveObject {
  @HiveField(2)
  bool pointObtained;

  @HiveField(3)
  DateTime pointObtainTime;

  @HiveField(0)
  String question;

  @HiveField(1)
  String answer;

  @HiveField(4)
  int exerciseKey;


  Question({
    this.pointObtained,
    this.pointObtainTime,
    this.question,
    this.answer,
    this.exerciseKey
  });

  factory Question.fromMap(Map<String, dynamic> json) => new Question (
    pointObtained: json["point_obtained"],
    pointObtainTime: json["point_obtain_time"],
    question: json["question"],
    answer: json["answer"],
    exerciseKey: json["exercise_key"],
  );

  Map<String, dynamic> toMap() => {
    "pointObtained": pointObtained,
    "pointObtainTime": pointObtainTime,
    "question": question,
    "answer": answer,
    "exercise_key": exerciseKey,
  };

}