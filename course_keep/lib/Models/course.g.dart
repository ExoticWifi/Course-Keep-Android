// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 1;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[4] as int,
      fields[3] as String,
      fields[5] as bool,
      fields[6] as bool,
      fields[7] as bool,
      fields[8] as bool,
      fields[9] as bool,
      fields[10] as bool,
      fields[11] as bool,
      fields[12] as String,
      fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.section)
      ..writeByte(4)
      ..write(obj.hours)
      ..writeByte(5)
      ..write(obj.sunday)
      ..writeByte(6)
      ..write(obj.monday)
      ..writeByte(7)
      ..write(obj.tuesday)
      ..writeByte(8)
      ..write(obj.wednesday)
      ..writeByte(9)
      ..write(obj.thursday)
      ..writeByte(10)
      ..write(obj.friday)
      ..writeByte(11)
      ..write(obj.saturday)
      ..writeByte(12)
      ..write(obj.startTime)
      ..writeByte(13)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
