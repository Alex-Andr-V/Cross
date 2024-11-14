import 'dart:async';
import 'package:book_finder/domain/repository/model/article.dart';
abstract class TopNewsRepositoryIterface {
Future<List<Article>> getTopNews();
}