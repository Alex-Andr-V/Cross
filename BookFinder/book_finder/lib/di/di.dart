import 'package:book_finder/app/features/home/bloc/home_block.dart';
import 'package:book_finder/data/dio/set_up.dart';
import 'package:book_finder/domain/repository/books/books_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();


Future<void> setupLocator() async {
  // Register Dio instance
  final dio = Dio();
  setUpDio();
  getIt.registerSingleton<Dio>(dio);

  // Register TalkerFlutter instance
  final talker = TalkerFlutter.init();
  getIt.registerSingleton(talker);

  // Register TopNewsRepository with Dio from GetIt
  getIt.registerSingleton(TopNewsRepository(dio: getIt<Dio>()));

  // Register HomeBloc, using TopNewsRepository from GetIt
  getIt.registerSingleton(HomeBloc(getIt.get<TopNewsRepository>()));
}

