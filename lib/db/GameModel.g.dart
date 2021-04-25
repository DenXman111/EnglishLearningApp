// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GameModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameAdapter extends TypeAdapter<Game> {
  @override
  final int typeId = 10;

  @override
  Game read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game(
      dbKey: fields[0] as int,
      title: fields[1] as String,
      storageType: fields[2] as String,
      description: fields[3] as String,
      exerciseKeys: (fields[4] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dbKey)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.storageType)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.exerciseKeys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
