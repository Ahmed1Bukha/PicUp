import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Fail, void>> login(
      {required String email, required String password});
  Future<Either<Fail, void>> register(
      {required String email,
      required String password,
      required String username});
}
