// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'some_data_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SomeDataAdapter extends TypeAdapter<SomeData> {
  @override
  final int typeId = 0;

  @override
  SomeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SomeData(
      correo: fields[0] as String,
      firstName: fields[2] as String,
      lastName: fields[3] as String,
      birthday: fields[4] as String,
      course: fields[5] as String,
      password: fields[1] as String,
      difficult: fields[6] as String,
      school: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SomeData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.correo)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.birthday)
      ..writeByte(5)
      ..write(obj.course)
      ..writeByte(6)
      ..write(obj.difficult)
      ..writeByte(7)
      ..write(obj.school);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SomeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
