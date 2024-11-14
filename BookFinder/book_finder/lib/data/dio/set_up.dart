import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:book_finder/di/di.dart';
void setUpDio() {
dio.options.baseUrl = ''; // общая часть адресов запросов https://api.thenewsapi.com/v1/news/
dio.options.queryParameters.addAll({
'api_token': '', // сюда нужно будет подставить ключ/токен, выданный при регистрации
});
dio.options.connectTimeout = const Duration(minutes: 1);
dio.options.receiveTimeout = const Duration(minutes: 1);
dio.interceptors.addAll([
TalkerDioLogger(
talker: talker,
settings: const TalkerDioLoggerSettings(
printRequestData: true,
printRequestHeaders: true,
),
),
]);
}