import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:get/get.dart';

import 'config/routes.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    locale: L.defaultLocale,
    fallbackLocale: L.fallbackLocale,
    localizationsDelegates: [
      // ... app-specific localization delegate[s] here
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    translations: L(),
    getPages: pages,
    initialRoute: RouteNames.SplashScreen,
  ));
}