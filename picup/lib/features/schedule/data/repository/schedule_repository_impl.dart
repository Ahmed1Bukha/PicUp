import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/schedule/data/datasource/schedule_local_datasource.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/features/schedule/domain/repository/schedule_repository.dart';

class ScheduleRepositoryImp extends ScheduleRepository {
  final ScheduleLocalDatasource localDatasource;

  ScheduleRepositoryImp({required this.localDatasource});
  @override
  Future<Either<Fail, void>> addCourse({required Course course}) async {
    try {
      final res = await localDatasource.addCourse(course);
      return Right("");
    } catch (e) {
      print(e);
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, void>> deleteCourse({required Course course}) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Fail, void>> editCourse({required Course course}) {
    // TODO: implement editCourse
    throw UnimplementedError();
  }

  @override
  Future<List<Course>> getCourses() async {
    try {
      final res = await localDatasource.getCourses();
      print(res);
      return res;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImp(localDatasource: ScheduleLocalDatasource());
});
