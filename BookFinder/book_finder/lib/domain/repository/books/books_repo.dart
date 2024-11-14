import 'dart:async';
import 'package:book_finder/data/endpoints.dart';
import 'package:book_finder/domain/repository/books/books_repo_interface.dart';
import 'package:book_finder/domain/repository/model/article.dart';
import 'package:dio/dio.dart';
class TopNewsRepository extends TopNewsRepositoryIterface {
TopNewsRepository({required this.dio});
final Dio dio;
@override
Future<List<Article>> getTopNews() async {
try {
final Response response = await dio.get(
Endpoints.topStories,
queryParameters: {
'locale': 'ru',
'language': 'ru',
},
);
final news = (response.data['data'] as List)
.map((e) => Article.fromJson(e))
.toList();
return news;
} on DioException catch (e) {
throw e.message.toString();
}
}
}