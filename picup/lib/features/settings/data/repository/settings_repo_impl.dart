import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:picup/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:picup/features/settings/domain/repository/settings_repository.dart';

class SettingsRepoImpl extends SettingsRepository {
  SettingsLocalDatasource localDatasource;
  SettingsRemoteDatasource remoteDatasource;
  SettingsRepoImpl(
      {required this.localDatasource, required this.remoteDatasource});
  @override
  Future<Either<Fail, void>> deleteAccount({required String password}) async {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Fail, void>> signout() async {
    try {
      await localDatasource.deleteAllCourses();
      await remoteDatasource.signOut();
      return Right("");
    } catch (e) {
      return Left(Fail(e));
    }
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepoImpl(
      localDatasource: SettingsLocalDatasource(),
      remoteDatasource: SettingsRemoteDatasource());
});
