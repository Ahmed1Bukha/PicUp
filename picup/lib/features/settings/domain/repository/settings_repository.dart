import 'package:dartz/dartz.dart';

abstract class SettingsRepository {
  Future<Either<Fail, void>> signout();
  Future<Either<Fail, void>> deleteAccount();
  Future<Either<Fail, String?>> fetchUsername();
}
