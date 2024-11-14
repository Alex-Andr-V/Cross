import 'package:book_finder/app/extensions/widget_extensions.dart';
import 'package:book_finder/app/features/home/bloc/home_block.dart';
import 'package:book_finder/app/widgets/article_card.dart';
import 'package:book_finder/app/widgets/article_card_detail.dart';
import 'package:book_finder/domain/repository/books/books_repo.dart';
import 'package:book_finder/domain/repository/model/article.dart';
import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/di/di.dart';
import 'package:go_router/go_router.dart';
import 'package:book_finder/lib/globals.dart' as globals;

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

int findBookById(List<Book> books, String targetId) {
  for (int j = 0; j < books.length; j++) {
    if (books[j].id == targetId) {
      return j; 
    }
  }
  return 0; 
}


class _ArticleScreenState extends State<ArticleScreen> {
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
          title: const Text('Подробная информация'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is HomeLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeLoadSuccess) {
              List<Book> articles = state.articles;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Книга',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    20.ph, 
                    
                    ArticleDetailCard(article: articles[findBookById(articles, globals.i)]), 
                  ],
                ),
              );
            }
            // if (state is HomeLoadFailure) {
            //   return ErrorCard(
            //     title: 'Ошибка',
            //     description: state.exception.toString(),
            //     onReload: () {
            //       _homeBloc.add(const HomeLoad());
            //     },
            //   );
            // }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
