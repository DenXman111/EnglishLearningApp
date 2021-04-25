import 'package:hive/hive.dart';

part 'QuestionModel.g.dart';

@HiveType(typeId: 3)
class Question extends HiveObject {
  int id;

  @HiveField(2)
  bool pointObtained;

  @HiveField(3)
  DateTime pointObtainTime;

  @HiveField(0)
  String question;

  @HiveField(1)
  String answer;

  @HiveField(4)
  String exerciseKey;

  @HiveField(5)
  String dbKey;


  @HiveField(6)
  List<String> allAnswers;


  Question({
    this.pointObtained,
    this.pointObtainTime,
    this.question,
    this.answer,
    this.exerciseKey,
    this.allAnswers,
    this.id
  }){
    dbKey = this.exerciseKey + "_" + this.id.toString();
  }
  //
  factory Question.fromMap(Map<String, dynamic> json) => new Question (
    pointObtained: false,
    pointObtainTime: null,
    question: json["question"],
    answer: json["answer"],
    exerciseKey: json["exercise_key"],
    id: json["question_id"],
    allAnswers: json["all_answers"],
  );

  Map<String, dynamic> toMap() => {
    "pointObtained": pointObtained,
    "pointObtainTime": pointObtainTime,
    "question": question,
    "answer": answer,
    "exercise_key": exerciseKey,
    "all_answers": allAnswers,
  };

}