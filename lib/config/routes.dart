import 'package:flutter_study/controller/CounterController.dart';
import 'package:flutter_study/controller/LangController.dart';
import 'package:flutter_study/screen/counter/counter_child_screen.dart';
import 'package:flutter_study/screen/counter/counter_screen.dart';
import 'package:flutter_study/screen/lang_screen.dart';
import 'package:get/get.dart';

abstract class RouteNames {
  static const CounterScreen = '/counter';
  static const CounterChildScreen = '/counter/child';
  static const LangScreen = '/lang';
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
    name: RouteNames.LangScreen,
    page: () => LangScreen(),
    binding: BindingsBuilder<LangController>(() => Get.lazyPut(() => LangController())),
  ),
];
