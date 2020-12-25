import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes.dart';

void main() {
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: pages,
      initialRoute: RouteNames.CounterScreen,
  ));
}