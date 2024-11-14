import 'package:flutter/material.dart';
import 'package:book_finder/app/router/router.dart';
import 'package:book_finder/app/theme/theme_data.dart';
class BooksFinderApp extends StatelessWidget {
const BooksFinderApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp.router(
title: 'Books finder',
theme: AppTheme.lightTheme,
routeInformationProvider: router.routeInformationProvider,
routeInformationParser: router.routeInformationParser,
routerDelegate: router.routerDelegate,
debugShowCheckedModeBanner: false,
);
}
}