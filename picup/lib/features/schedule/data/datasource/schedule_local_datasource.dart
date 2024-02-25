import 'package:hive/hive.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

class ScheduleLocalDatasource {
  Future<List<Course>> getCourses() async {
    var box = await Hive.openBox('mybox');

    final courses = box.values;
    print(courses);
    return courses.toList().cast<Course>();
  }

  Future<void> addCourse(Course course) async {
    var box = await Hive.openBox('mybox');
    await box.put(course.name, course);
  }

  Future<void> editCourse(Course course) async {
    var box = await Hive.openBox('mybox');
    await box.delete(course.name);
    await box.put(course.name, course);
  }

  Future<void> deleteCourse(Course course) async {
    var box = await Hive.openBox('mybox');
    await box.delete(course.name);
  }
}
