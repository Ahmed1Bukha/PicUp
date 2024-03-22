import 'package:picup/features/schedule/domain/entity/coures.dart';

getDayNum(DaysCourse day) {
  switch (day) {
    case DaysCourse.sun:
      return 0;

    case DaysCourse.mon:
      return 1;
    case DaysCourse.tue:
      return 2;
    case DaysCourse.wed:
      return 3;
    case DaysCourse.thu:
      return 4;
    case DaysCourse.fri:
      return 5;
    case DaysCourse.sat:
      return 6;
  }
}
