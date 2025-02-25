import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:book_finder/app/features/home/home_screen.dart';
import 'package:book_finder/app/features/article/article_screen.dart';
import 'package:book_finder/login_screen.dart';
import 'package:book_finder/sign_up_screen.dart';
import 'package:book_finder/di/di.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GlobalKey<NavigatorState> _rootNavigationKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  observers: [TalkerRouteObserver(talker)],
  initialLocation: '/home', // Начальный маршрут
  navigatorKey: _rootNavigationKey,
  routes: <RouteBase>[
    // Главный экран
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        );
      },
      routes: [
        // Детали статьи (книги)
        GoRoute(
          path: 'article/:id',
pageBuilder: (context, state) {
            return NoTransitionPage<void>(
              key: state.pageKey,
              child: const ArticleScreen(bookId: '',),
            );
          },
        ),
      ],
    ),

    // Экран входа
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child:  LoginScreen(),
        );
      },
    ),

    // Экран регистрации
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child:  SignUpScreen(),
        );
      },
    ),
  ],
);