part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddToFavoritesEvent extends FavoritesEvent {
  final String bookId;
  final String title;
  final String author;

  const AddToFavoritesEvent({
    required this.bookId,
    required this.title,
    required this.author,
  });

  @override
  List<Object> get props => [bookId, title, author];
}

class RemoveFromFavoritesEvent extends FavoritesEvent {
  final String bookId;

  const RemoveFromFavoritesEvent({required this.bookId});

  @override
  List<Object> get props => [bookId];
}

class LoadFavoritesEvent extends FavoritesEvent {}