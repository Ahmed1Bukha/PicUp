import 'package:hive/hive.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

class CameraLocalDatasource {
  Future<List<Course>> getCourses() async {
    var box = await Hive.openBox('course');

    final courses = box.values;
    print(courses);
    return courses.toList().cast<Course>();
  }
}
