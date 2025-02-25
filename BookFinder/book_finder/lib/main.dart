import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/app/features/article/article_screen.dart';
import 'package:book_finder/app/features/auth/auth_bloc.dart';
import 'package:book_finder/auth_service.dart';
import 'package:book_finder/app/features/home/home_screen.dart';
import 'package:book_finder/login_screen.dart';
import 'package:book_finder/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart'; // Убедитесь, что этот файл сгенерирован
import 'package:book_finder/di/di.dart';
import 'package:talker_flutter/talker_flutter.dart';

// Создаем экземпляр GoRouter с маршрутами
final GoRouter router = GoRouter(
   initialLocation: '/login', // Начальный маршрут
  routes: [
    // Главный экран
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),

    // Экран входа
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),

    // Экран регистрации
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpScreen(),
    ),

    // Экран деталей книги (с параметром :id)
    GoRoute(
      path: '/book/:id',
      builder: (context, state) {
        final bookId = state.pathParameters['id']!; // Получаем параметр id
        return ArticleScreen(bookId: bookId); // Передаем bookId в ArticleScreen
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (details) => talker.handle(
    details.exception,
    details.stack,
  );

  runApp(const BooksFinderApp());
}

class BooksFinderApp extends StatelessWidget {
  const BooksFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthService()),
        ),
        // Добавьте другие BlocProvider, если они есть
      ],
      child: MaterialApp.router(
        routerConfig: router, // Используем GoRouter
        title: 'Books Finder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}