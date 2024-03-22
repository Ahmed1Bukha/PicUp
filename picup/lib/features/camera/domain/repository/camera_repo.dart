import 'package:dartz/dartz.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

abstract class CameraRepository {
  Future<Either<Fail, List<Course>>> getCourses();
}
