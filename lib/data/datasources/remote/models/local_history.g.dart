// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalHistorialAdapter extends TypeAdapter<LocalHistorial> {
  @override
  final int typeId = 1;

  @override
  LocalHistorial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalHistorial(
      id: fields[0] as int,
      time: fields[1] as int,
      email: fields[2] as String,
      question1: fields[3] as bool,
      question2: fields[4] as bool,
      question3: fields[5] as bool,
      question4: fields[6] as bool,
      question5: fields[7] as bool,
      question6: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocalHistorial obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.question1)
      ..writeByte(4)
      ..write(obj.question2)
      ..writeByte(5)
      ..write(obj.question3)
      ..writeByte(6)
      ..write(obj.question4)
      ..writeByte(7)
      ..write(obj.question5)
      ..writeByte(8)
      ..write(obj.question6);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalHistorialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
