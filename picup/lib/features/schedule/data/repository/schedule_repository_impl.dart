import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/schedule/data/datasource/schedule_local_datasource.dart';
import 'package:picup/features/schedule/data/datasource/schedule_remote_datasource.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/features/schedule/domain/repository/schedule_repository.dart';

class ScheduleRepositoryImp extends ScheduleRepository {
  final ScheduleLocalDatasource localDatasource;
  final ScheduleRemoteDatasource remoteDatasource;

  ScheduleRepositoryImp(
      {required this.localDatasource, required this.remoteDatasource});
  @override
  Future<Either<Fail, void>> addCourse({required Course course}) async {
    try {
      remoteDatasource.addCourse(course);
      final res = await localDatasource.addCourse(course);
      return Right("");
    } catch (e) {
      print(e);
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, void>> deleteCourse({required Course course}) async {
    try {
      remoteDatasource.deleteCourse(course);
      final res = await localDatasource.deleteCourse(course);
      return Right("");
    } catch (e) {
      print(e);
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, void>> editCourse({required Course course}) async {
    try {
      final res = await localDatasource.editCourse(course);
      return Right("");
    } catch (e) {
      print(e);
      return Left(Fail(e.toString()));
    }
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

  @override
  Future<Either<Fail, void>> deleteAllCourses() async {
    try {
      final res = localDatasource.deleteAllCourses();
      return Right("");
    } catch (e) {
      print(e);
      return Left(Fail(e.toString()));
    }
  }
}

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImp(
      localDatasource: ScheduleLocalDatasource(),
      remoteDatasource: ScheduleRemoteDatasource());
});
