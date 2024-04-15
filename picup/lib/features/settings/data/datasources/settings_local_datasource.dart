import 'package:hive/hive.dart';

class SettingsLocalDatasource {
  Future<void> deleteAllCourses() async {
    var box = await Hive.openBox('course');
    await box.clear();
  }
}
