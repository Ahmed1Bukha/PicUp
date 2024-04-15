import 'package:calendar_view/calendar_view.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:picup/features/camera/presentation/screens/home_page.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/util/constants.dart';
import 'package:picup/util/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(DaysCourseAdapter());

  var box = await Hive.openBox('course');

  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user!.isAnonymous == false) {
      final courses = box.values;

      for (var course in courses) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('courses')
            .doc(course.id)
            .set(course.toJson());

        print("upaated course ${course.id}");
      }
    }
  } catch (e) {
    print('Error is : $e');
  }

  runApp(ProviderScope(
    overrides: [
      camereDescProvider.overrideWithValue(_cameras),
    ],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData(
          scaffoldBackgroundColor: ColorConstants.PRIMARY_500,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: ColorConstants.PRIMARY_100)),
          fontFamily: "Inter"),
      routerConfig: router,
      debugShowCheckedModeBanner: true,
    );
  }
}

final eventControllerProvider = Provider<EventController>((ref) {
  return EventController();
});
