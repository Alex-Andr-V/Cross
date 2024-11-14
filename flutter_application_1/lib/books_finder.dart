import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/router/router.dart';
import 'package:flutter_application_1/app/theme/theme_data.dart';
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