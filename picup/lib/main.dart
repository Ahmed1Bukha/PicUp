import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:picup/features/schedule/domain/entity/coures.dart';
import 'package:picup/util/constants.dart';
import 'package:picup/util/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(DaysCourseAdapter());

  var box = await Hive.openBox('mybox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CalendarControllerProvider(
      controller: ref.watch(eventControllerProvider),
      child: MaterialApp.router(
        theme: ThemeData(
            scaffoldBackgroundColor: ColorConstants.PRIMARY_500,
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: ColorConstants.PRIMARY_100)),
            fontFamily: "Inter"),
        routerConfig: router,
        debugShowCheckedModeBanner: true,
      ),
    );
  }
}

final eventControllerProvider = Provider<EventController>((ref) {
  return EventController();
});
