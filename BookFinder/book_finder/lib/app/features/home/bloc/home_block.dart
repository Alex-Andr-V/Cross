import 'dart:async';
import 'package:book_finder/domain/repository/books/books_repo.dart';
import 'package:book_finder/domain/repository/model/article.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:books_finder/books_finder.dart';
import 'package:book_finder/di/di.dart';
part "home_event.dart";
part "home_state.dart";
class HomeBloc extends Bloc<HomeEvent, HomeState> {
final TopNewsRepository topNewsRepository;
HomeBloc(this.topNewsRepository) : super(HomeInitial()) {
on<HomeLoad>(_homeLoad);
}
Future<void> _homeLoad(event, emit) async {
try {
if (state is! HomeLoadSuccess) {
emit(HomeLoadInProgress());
}




final List<Book> articles = await queryBooks(
 'Пушкин',
 queryType: QueryType.intitle,
 maxResults: 10,
 printType: PrintType.books,
 orderBy: OrderBy.relevance,
);
emit(HomeLoadSuccess(
articles: articles,
));
} catch (exception, state) {
emit(HomeLoadFailure(exception: exception));
talker.handle(exception, state);
} finally {
event.completer?.complete();
}
}
@override
void onError(Object error, StackTrace stackTrace) {
super.onError(error, stackTrace);
talker.handle(error, stackTrace);
}
}