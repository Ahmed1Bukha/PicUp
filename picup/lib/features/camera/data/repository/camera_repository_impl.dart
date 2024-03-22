import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/camera/data/datasources/camera_local_datasource.dart';
import 'package:picup/features/camera/domain/repository/camera_repo.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

class CameraRepositoryImpl extends CameraRepository {
  CameraRepositoryImpl({required this.localDataSource});

  final CameraLocalDatasource localDataSource;

  @override
  Future<Either<Fail, List<Course>>> getCourses() async {
    try {
      final res = await localDataSource.getCourses();
      return Right(res);
    } catch (e) {
      return Left(Fail(e));
    }
  }
}

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraRepositoryImpl(localDataSource: CameraLocalDatasource());
});
