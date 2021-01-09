import 'package:flutter_study/controller/CounterController.dart';
import 'package:flutter_study/screen/SplashScreen.dart';
import 'package:flutter_study/screen/counter/counter_child_screen.dart';
import 'package:flutter_study/screen/counter/counter_screen.dart';
import 'package:get/get.dart';

abstract class RouteNames {
  static const CounterScreen = '/counter';
  static const CounterChildScreen = '/counter/child';
  static const SplashScreen = '/splash';
}

final pages = [
  GetPage(
    name: RouteNames.CounterScreen,
    page: () => CounterScreen(),
    binding: BindingsBuilder<CounterController>(() => Get.lazyPut(() => CounterController())),
  ),
  GetPage(
    name: RouteNames.CounterChildScreen,
    page: () => CounterChildScreen(),
  ),
  GetPage(
    name: RouteNames.SplashScreen,
    page: () => SplashScreen(),
  ),
];
