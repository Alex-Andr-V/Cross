import 'package:book_finder/app/extensions/widget_extensions.dart';
import 'package:book_finder/app/features/home/bloc/home_block.dart';
import 'package:book_finder/app/widgets/article_card.dart';
import 'package:book_finder/domain/repository/books/books_repo.dart';
import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/di/di.dart';
import 'package:book_finder/app/features/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = HomeBloc(getIt<TopNewsRepository>());

  @override
  void initState() {
    _homeBloc.add(const HomeLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Главная'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Отправляем событие выхода в AuthBloc
                context.read<AuthBloc>().add(LogoutRequested());
                                     // context.go('/login');    //    context.go('/login');

              },
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              // Перенаправляем на экран логина после выхода
              context.go('/login');
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeBloc,
            builder: (context, state) {
              if (state is HomeLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeLoadSuccess) {
                List<Book> articles = state.articles;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Книги',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      20.ph,
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(
                            article: articles[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return 20.ph;
                        },
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}