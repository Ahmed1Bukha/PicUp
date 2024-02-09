import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picup/features/auth/presentation/screen/login_page.dart';
import 'package:picup/features/auth/presentation/screen/main_auth.dart';
import 'package:picup/features/camera/presentation/home_page.dart';
import 'package:picup/features/on_boarding/presentation/screen/on_boarding_main.dart';

final GoRouter router = GoRouter(
  initialLocation: "/onboarding",
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
            path: 'auth',
            builder: (context, state) => const MainAuth(),
            routes: [
              GoRoute(
                path: 'login',
                builder: (context, state) => const LoginPage(),
              ),
            ]),
        // GoRoute(
        //   path: 'settings',
        // ),
        // GoRoute(
        //   path: 'schedule',
        // ),
        // GoRoute(path: 'courses', routes: [
        //   GoRoute(
        //     path: ':id',
        //     //TODO: take query
        //   ),
        // ]),
      ],
    ),
  ],
);
