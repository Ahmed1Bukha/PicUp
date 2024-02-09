import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:picup/util/constants.dart';
import 'package:picup/util/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData(
          scaffoldBackgroundColor: ColorConstants.PRIMARY_500,
          fontFamily: "Inter"),
      routerConfig: router,
      debugShowCheckedModeBanner: true,
    );
  }
}
