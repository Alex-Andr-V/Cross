import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Добавить книгу в избранное
  Future<void> addToFavorites(String bookId, String title, String author) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('favorites').add({
        'userId': user.uid,
        'bookId': bookId,
        'title': title,
        'author': author,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      throw Exception('Пользователь не авторизован');
    }
  }

  // Удалить книгу из избранного
  Future<void> removeFromFavorites(String bookId) async {
    final user = _auth.currentUser;
    if (user != null) {
      final query = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: user.uid)
          .where('bookId', isEqualTo: bookId)
          .get();
      for (var doc in query.docs) {
        await doc.reference.delete();
      }
    } else {
      throw Exception('Пользователь не авторизован');
    }
  }

  // Проверить, добавлена ли книга в избранное
  Future<bool> isFavorite(String bookId) async {
    final user = _auth.currentUser;
    if (user != null) {
      final query = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: user.uid)
          .where('bookId', isEqualTo: bookId)
          .get();
      return query.docs.isNotEmpty;
    } else {
      throw Exception('Пользователь не авторизован');
    }
  }
}