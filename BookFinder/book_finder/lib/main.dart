import 'package:flutter/material.dart';
import 'package:book_finder/books_finder.dart';
import 'package:book_finder/di/di.dart';
void main() async {
WidgetsFlutterBinding.ensureInitialized();
setupLocator();
FlutterError.onError = (details) => talker.handle(
details.exception,
details.stack,
);
runApp(const BooksFinderApp());
}