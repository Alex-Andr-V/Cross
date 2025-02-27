import 'package:book_finder/app/extensions/widget_extensions.dart';
import 'package:book_finder/app/features/home/bloc/home_block.dart';
import 'package:book_finder/app/widgets/article_card.dart';
import 'package:book_finder/app/widgets/article_card_detail.dart';
import 'package:book_finder/domain/repository/books/books_repo.dart';
import 'package:book_finder/domain/repository/model/article.dart';
import 'package:book_finder/favorites_bloc.dart';
import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/di/di.dart';
import 'package:go_router/go_router.dart';
import 'package:book_finder/lib/globals.dart' as globals;
import 'package:book_finder/favorites_bloc.dart';

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
  final String bookId;

  const ArticleScreen({required this.bookId});

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
    context.read<FavoritesBloc>().add(LoadFavoritesEvent()); // Загружаем избранное при инициализации
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Подробная информация'),
          actions: [
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                bool isFavorite = false;
                if (state is FavoritesLoaded) {
                  isFavorite = state.favorites.any((favorite) => favorite['bookId'] == widget.bookId);
                }
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    final book = _getBookById(widget.bookId);
                    if (book != null) {
                      if (isFavorite) {
                        context.read<FavoritesBloc>().add(RemoveFromFavoritesEvent(bookId: book.id));
                      } else {
                        context.read<FavoritesBloc>().add(AddToFavoritesEvent(
                          bookId: book.id,
                          title: book.info.title,
                          author: book.info.authors.join(', '),
                        ));
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is HomeLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeLoadSuccess) {
              List<Book> articles = state.articles;
              final book = _getBookById(widget.bookId);
              if (book != null) {
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
                      ArticleDetailCard(article: book),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('Книга не найдена'));
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  // Найти книгу по ID
  Book? _getBookById(String bookId) {
    final state = _homeBloc.state;
    if (state is HomeLoadSuccess) {
      return state.articles.firstWhere(
        (book) => book.id == bookId,
       // orElse: () => null,
      );
    }
    return null;
  }
}