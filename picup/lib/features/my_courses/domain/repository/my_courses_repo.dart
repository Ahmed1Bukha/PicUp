import 'package:dartz/dartz.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

abstract class MyCoursesRespository {
  Future<List<Course>> getCourses();
}
