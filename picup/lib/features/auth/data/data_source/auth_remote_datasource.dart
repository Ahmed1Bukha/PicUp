import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasource {
  Future<void> login({required String email, required String password}) async {
    try {
      print(email);
      print(password);
      final res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(res);
    } catch (e) {
      throw Exception(e);
    }
  }
}
