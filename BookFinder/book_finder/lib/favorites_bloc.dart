import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FavoritesBloc() : super(FavoritesInitial()) {
    on<AddToFavoritesEvent>(_onAddToFavorites);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavorites);
    on<LoadFavoritesEvent>(_onLoadFavorites);
  }

  Future<void> _onAddToFavorites(
    AddToFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('favorites').add({
          'userId': user.uid,
          'bookId': event.bookId,
          'title': event.title,
          'author': event.author,
          'timestamp': FieldValue.serverTimestamp(),
        });
        add(LoadFavoritesEvent()); // Перезагружаем список избранного
      } else {
        emit(FavoritesError('Пользователь не авторизован'));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final query = await _firestore
            .collection('favorites')
            .where('userId', isEqualTo: user.uid)
            .where('bookId', isEqualTo: event.bookId)
            .get();
        for (var doc in query.docs) {
          await doc.reference.delete();
        }
        add(LoadFavoritesEvent()); // Перезагружаем список избранного
      } else {
        emit(FavoritesError('Пользователь не авторизован'));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final query = await _firestore
            .collection('favorites')
            .where('userId', isEqualTo: user.uid)
            .get();
        final favorites = query.docs.map((doc) => doc.data()).toList();
        emit(FavoritesLoaded(favorites));
      } else {
        emit(FavoritesError('Пользователь не авторизован'));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}