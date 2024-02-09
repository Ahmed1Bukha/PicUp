import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:picup/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImp(this.remoteDatasource);
  @override
  Future<Either<Fail, void>> login(
      {required String email, required String password}) async {
    try {
      final res =
          await remoteDatasource.login(email: email, password: password);
      return Right("succesed");
    } catch (e) {
      return Left(Fail(e));
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final repo = AuthRepositoryImp(AuthRemoteDatasource());

  return repo;
});
