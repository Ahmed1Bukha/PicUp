import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picup/features/settings/data/repository/settings_repo_impl.dart';

final fetchUsernameProvider = FutureProvider<String?>((ref) async {
  final res = await ref.read(settingsRepositoryProvider).fetchUsername();
  return res.fold((l) {
    return "NA";
  }, (r) {
    print(r);
    return r;
  });
});
