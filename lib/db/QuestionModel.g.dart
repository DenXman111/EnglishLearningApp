// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 3;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      pointObtained: fields[2] as bool,
      pointObtainTime: fields[3] as DateTime,
      question: fields[0] as String,
      answer: fields[1] as String,
      exerciseKey: fields[4] as int,
    )..dbKey = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(6)
      ..writeByte(2)
      ..write(obj.pointObtained)
      ..writeByte(3)
      ..write(obj.pointObtainTime)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(4)
      ..write(obj.exerciseKey)
      ..writeByte(5)
      ..write(obj.dbKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
