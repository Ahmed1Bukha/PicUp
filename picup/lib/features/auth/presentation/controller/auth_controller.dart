import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/auth/data/repository/auth_repository_impl.dart';
import 'package:picup/features/schedule/presentation/controllers/get_courses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthenticationNotifier extends _$AuthenticationNotifier {
  @override
  FutureOr<void> build() {}

  Future<Either<Fail, void>> login(
      {required String email, required String password}) async {
    state = const AsyncValue<void>.loading();
    final res = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    ref.invalidate(getCoursesProvider);
    state = const AsyncValue.data(null);
    return res;
  }

  Future<Either<Fail, void>> register(
      {required String email,
      required String password,
      required String username}) async {
    state = const AsyncValue<void>.loading();
    final res = await ref
        .read(authRepositoryProvider)
        .register(email: email, password: password, username: username);
    ref.invalidate(getCoursesProvider);
    state = const AsyncValue.data(null);
    return res;
  }
}
