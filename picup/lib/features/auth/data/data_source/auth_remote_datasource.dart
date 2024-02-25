import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      print(email);
      print(password);
      final res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = res.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
        });
        print("User registered and username saved successfully!");
      }

      print(res);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
