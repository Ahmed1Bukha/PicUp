import 'package:firebase_auth/firebase_auth.dart';

class SettingsRemoteDatasource {
  final user = FirebaseAuth.instance.currentUser;
  Future<void> deleteAccount() async {
    await user?.delete();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
