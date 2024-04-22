import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:picup/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:picup/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImp(this.remoteDatasource, this.localDatasource);
  @override
  Future<Either<Fail, void>> login(
      {required String email, required String password}) async {
    try {
      await localDatasource.saveEmail(email);
      final res =
          await remoteDatasource.login(email: email, password: password);
      final userName = await remoteDatasource.fetchUsername(res);
      await localDatasource.saveUsername(userName);
      await saveCourses(res);
      return Right("succesed");
    } catch (e) {
      return Left(Fail(e));
    }
  }

  @override
  Future<Either<Fail, void>> register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final res = await remoteDatasource.register(
          email: email, password: password, username: username);
      await localDatasource.saveEmail(email);
      await localDatasource.saveUsername(username);
      return const Right("");
    } catch (e) {
      return Left(Fail(e));
    }
  }

  @override
  Future<void> saveCourses(String uid) async {
    final courses = await remoteDatasource.fetchCourses(uid);
    await localDatasource.saveCourses(courses);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final repo = AuthRepositoryImp(AuthRemoteDatasource(), AuthLocalDatasource());

  return repo;
});
