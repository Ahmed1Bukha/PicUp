import 'package:hive/hive.dart';
import 'package:picup/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDatasource {
  Future<void> deleteAllCourses() async {
    var box = await Hive.openBox('course');
    await box.clear();
  }

  Future<void> deleteEmailAndUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(SaveLocalConstant.email);
    prefs.remove(SaveLocalConstant.username);
  }

  Future<String?> fetchUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SaveLocalConstant.username);
  }
}
