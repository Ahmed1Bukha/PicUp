import 'package:calendar_view/calendar_view.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:picup/features/camera/presentation/screens/home_page.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/util/constants.dart';
import 'package:picup/util/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> _cameras = [];
  try {
    _cameras = await availableCameras();
  } catch (e) {
    print('Error is : $e');
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(DaysCourseAdapter());

  var box = await Hive.openBox('course');

  var initiLocation = '/';
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final hasEmail = prefs.getString(SaveLocalConstant.email);
    final firstTime = prefs.getBool(SaveLocalConstant.firstTime);

    print('hasEmail: $hasEmail');
    if (firstTime == null) {
      initiLocation = '/onboarding';
      prefs.setBool(SaveLocalConstant.firstTime, true);
    } else if (hasEmail == null) {
      initiLocation = '/auth';
    }

    //NOTE: This may cause as it will take a long time if the user has slow internet connection.

    // final user = FirebaseAuth.instance.currentUser;
    // if (user!.isAnonymous == false) {
    //   final courses = box.values;

    //   for (var course in courses) {
    //     await FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(user!.uid)
    //         .collection('courses')
    //         .doc(course.id)
    //         .set(course.toJson());

    //     print("upaated course ${course.id}");
    //   }
    // }
  } catch (e) {
    print('Error is : $e');
  }

  runApp(ProviderScope(
    overrides: [
      camereDescProvider.overrideWithValue(_cameras),
    ],
    child: MyApp(initiLocation),
  ));
}

class MyApp extends ConsumerWidget {
  MyApp(this.initiLocation, {super.key});
  String? initiLocation;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData(
          popupMenuTheme: PopupMenuThemeData(
              color: ColorConstants.PRIMARY_500,
              textStyle: TextBodyConstants.bold14
                  .copyWith(color: ColorConstants.PRIMARY_100)),
          scaffoldBackgroundColor: ColorConstants.PRIMARY_500,
          dialogTheme: DialogTheme(
            backgroundColor: ColorConstants.PRIMARY_500,
            titleTextStyle: TextHeadersContatns.h5
                .copyWith(color: ColorConstants.PRIMARY_50),
            contentTextStyle: TextBodyConstants.bold16
                .copyWith(color: ColorConstants.PRIMARY_100),
          ),
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: ColorConstants.PRIMARY_100)),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextBodyConstants
                .bold16
                .copyWith(color: ColorConstants.PRIMARY_50)),
          )),
          fontFamily: "Inter"),
      routerConfig: ref.read(goRouterProvider(initiLocation)),
      debugShowCheckedModeBanner: false,
    );
  }
}

final eventControllerProvider = Provider<EventController>((ref) {
  return EventController();
});
