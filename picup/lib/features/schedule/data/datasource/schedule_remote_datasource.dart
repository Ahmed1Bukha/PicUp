import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';

class ScheduleRemoteDatasource {
  final user = FirebaseAuth.instance.currentUser;
  Future<void> addCourse(Course course) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('courses')
        .doc(course.id)
        .set(course.toJson());
    print("added");
  }

  Future<void> deleteCourse(Course course) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('courses')
          .doc(course.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
