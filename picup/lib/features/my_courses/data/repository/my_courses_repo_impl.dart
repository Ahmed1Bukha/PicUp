import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/my_courses/data/datasource/my_courses_local_datasource.dart';
import 'package:picup/features/my_courses/domain/repository/my_courses_repo.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

class MyCourseRepositoryImpl extends MyCoursesRespository {
  final MyCourseLocalDatasource localDatasource;

  MyCourseRepositoryImpl({required this.localDatasource});
  @override
  Future<List<Course>> getCourses() async {
    try {
      final res = await localDatasource.getCourses();
      return res;
    } catch (e) {
      throw e;
    }
  }
}

final myCourseRepositoryProvider = Provider<MyCoursesRespository>((ref) {
  return MyCourseRepositoryImpl(localDatasource: MyCourseLocalDatasource());
});
