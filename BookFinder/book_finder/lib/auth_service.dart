import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_finder/domain/domain.dart';
class AuthService extends AuthServiceInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logOut() async {
    try {
      await _auth.signOut(); // Выход из Firebase
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Ошибка выхода";
    }
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser; // Возвращаем текущего пользователя
  }
@override
Future<void> signUp({
required String email,
required String password,
}) async {
try {
await FirebaseAuth.instance.createUserWithEmailAndPassword(
email: email,
password: password,
);
} on FirebaseAuthException catch (e) {
throw e.message.toString();
}
}
@override
Future<void> logIn({
required String email,
required String password,
}) async {
try {
await FirebaseAuth.instance.signInWithEmailAndPassword(
email: email,
password: password,
);
} on FirebaseAuthException catch (e) {
throw e.message.toString();
}
}
Future<void> logOut2() async {
try {
await FirebaseAuth.instance.signOut();
} on FirebaseAuthException catch (e) {
throw e.message.toString();
}
}
}

class AuthServiceInterface {
}

