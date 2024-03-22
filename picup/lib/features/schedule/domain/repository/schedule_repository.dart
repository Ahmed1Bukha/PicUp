import 'package:dartz/dartz.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

abstract class ScheduleRepository {
  Future<List<Course>> getCourses();
  Future<Either<Fail, void>> addCourse({required Course course});
  Future<Either<Fail, void>> editCourse({required Course course});
  Future<Either<Fail, void>> deleteCourse({required Course course});
  Future<Either<Fail, void>> deleteAllCourses();
}
