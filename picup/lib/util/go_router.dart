import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/features/auth/presentation/screen/login_page.dart';
import 'package:picup/features/auth/presentation/screen/main_auth.dart';
import 'package:picup/features/auth/presentation/screen/register_page.dart';
import 'package:picup/features/camera/presentation/screens/home_page.dart';
import 'package:picup/features/on_boarding/presentation/screen/on_boarding_main.dart';
import 'package:picup/features/schedule/presentation/screens/schedule.dart';

final GoRouter router = GoRouter(
  initialLocation: "/schedule",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'onboarding',
          builder: (context, state) => const OnBoardingMain(),
        ),
        GoRoute(
          path: 'schedule',
          builder: (context, state) => const SchedulePage(),
        ),
        GoRoute(
            path: 'auth',
            builder: (context, state) => const MainAuth(),
            routes: [
              GoRoute(
                path: 'login',
                builder: (context, state) => const LoginPage(),
              ),
              GoRoute(
                path: 'register',
                builder: (context, state) => const RegisterPage(),
              ),
            ]),
      ],
    ),
  ],
);
