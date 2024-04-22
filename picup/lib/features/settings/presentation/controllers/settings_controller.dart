import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/settings/data/repository/settings_repo_impl.dart';

class SettingsControllerNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    //Nothing to be here
  }

  Future<Either<Fail, void>> signOut() async {
    state = const AsyncValue.loading();
    final res = await ref.read(settingsRepositoryProvider).signout();
    state = const AsyncValue.data("");
    return res;
  }

  Future<Either<Fail, void>> deleteAccount() async {
    state = const AsyncValue.loading();
    final res = await ref.read(settingsRepositoryProvider).deleteAccount();
    state = const AsyncValue.data("");
    return res;
  }
}

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsControllerNotifier, void>(
        SettingsControllerNotifier.new);
