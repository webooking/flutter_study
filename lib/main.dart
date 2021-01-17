import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'config/routes.dart';

Future<void> main() async {
  await GetStorage.init();

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
    theme: theme(),
    getPages: pages,
    initialRoute: RouteNames.initialRoute,
  ));
}