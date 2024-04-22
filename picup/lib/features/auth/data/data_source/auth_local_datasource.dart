import 'package:hive/hive.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SaveLocalConstant.email, email);
  }

  Future<void> saveUsername(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SaveLocalConstant.username, name);
  }

  Future<void> saveFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SaveLocalConstant.firstTime, true);
  }

  Future<void> saveCourses(List<Course> courses) async {
    var box = await Hive.openBox('course');
    for (Course course in courses) {
      await box.put(course.id, course);
    }
  }
}
