import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

class AuthRemoteDatasource {
  Future<String> login(
      {required String email, required String password}) async {
    try {
      print(email);
      print(password);

      final res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(res);
      print(res);
      final uid = res.user!.uid;
      return uid;
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

  Future<List<Course>> fetchCourses(String uid) async {
    try {
      final res = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('courses')
          .get();
      final courses = res.docs.map((e) => Course.fromJson(e.data())).toList();
      print(courses);
      return courses;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> fetchUsername(String uid) async {
    try {
      final res =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final username = res.data()!['username'];
      print(username);
      return username;
    } catch (e) {
      throw Exception(e);
    }
  }
}
