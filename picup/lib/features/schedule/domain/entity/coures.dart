import 'package:hive/hive.dart';

part 'coures.g.dart';

@HiveType(typeId: 1)
class Course {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<DaysCourse> days;
  @HiveField(2)
  final DateTime startTime;
  @HiveField(3)
  final DateTime endTime;

  Course(
      {required this.name,
      required this.days,
      required this.startTime,
      required this.endTime});
}

@HiveType(typeId: 2)
enum DaysCourse {
  @HiveField(0)
  sun,
  @HiveField(1)
  mon,
  @HiveField(2)
  tue,
  @HiveField(3)
  wed,
  @HiveField(4)
  thu,
  @HiveField(5)
  fri,
  @HiveField(6)
  sat,
}
