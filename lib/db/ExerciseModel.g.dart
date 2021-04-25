// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExerciseModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 2;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      gameKey: fields[0] as int,
      dbKey: fields[2] as String,
      description: fields[3] as String,
    )..questions = (fields[1] as List)?.cast<Question>();
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.gameKey)
      ..writeByte(1)
      ..write(obj.questions)
      ..writeByte(2)
      ..write(obj.dbKey)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
