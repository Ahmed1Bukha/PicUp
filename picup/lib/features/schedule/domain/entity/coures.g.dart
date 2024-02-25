// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coures.dart';

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
      name: fields[0] as String,
      days: (fields[1] as List).cast<DaysCourse>(),
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
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

class DaysCourseAdapter extends TypeAdapter<DaysCourse> {
  @override
  final int typeId = 2;

  @override
  DaysCourse read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DaysCourse.sun;
      case 1:
        return DaysCourse.mon;
      case 2:
        return DaysCourse.tue;
      case 3:
        return DaysCourse.wed;
      case 4:
        return DaysCourse.thu;
      case 5:
        return DaysCourse.fri;
      case 6:
        return DaysCourse.sat;
      default:
        return DaysCourse.sun;
    }
  }

  @override
  void write(BinaryWriter writer, DaysCourse obj) {
    switch (obj) {
      case DaysCourse.sun:
        writer.writeByte(0);
        break;
      case DaysCourse.mon:
        writer.writeByte(1);
        break;
      case DaysCourse.tue:
        writer.writeByte(2);
        break;
      case DaysCourse.wed:
        writer.writeByte(3);
        break;
      case DaysCourse.thu:
        writer.writeByte(4);
        break;
      case DaysCourse.fri:
        writer.writeByte(5);
        break;
      case DaysCourse.sat:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DaysCourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
