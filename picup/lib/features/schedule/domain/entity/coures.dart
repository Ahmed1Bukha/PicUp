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
  @HiveField(4)
  final String id;

  Course(
      {required this.name,
      required this.days,
      required this.startTime,
      required this.endTime,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'days': days.map((day) => day.toString().split('.').last).toList(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'id': id,
    };
  }

  bool hasDay(DaysCourse day) {
    print(day);
    return days.contains(day);
  }

  String getDays() {
    String daysString = "";
    days.forEach((element) {
      daysString += element.toString().split('.').last + " ";
    });
    return daysString;
  }

  DaysCourse getDayName(String day) {
    switch (day) {
      case "Saturday":
        return DaysCourse.sat;

      case "Sunday":
        return DaysCourse.sun;
      case "Monday":
        return DaysCourse.mon;
      case "Tuesday":
        return DaysCourse.tue;
      case "Wednesday":
        return DaysCourse.wed;
      case "Thursday":
        return DaysCourse.thu;
      case "Friday":
        return DaysCourse.fri;
      default:
        return DaysCourse.sun;
    }
  }
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
