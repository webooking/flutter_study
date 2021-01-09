import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/controller/CounterController.dart';
import 'package:flutter_study/screen/HomeScreen.dart';
import 'package:flutter_study/screen/SplashScreen.dart';
import 'package:flutter_study/screen/counter/counter_child_screen.dart';
import 'package:flutter_study/screen/counter/counter_screen.dart';
import 'package:flutter_study/screen/signIn/SignInScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class RouteNames {
  static const CounterScreen = '/counter';
  static const CounterChildScreen = '/counter/child';
  static const SplashScreen = '/splash';
  static const SignInScreen = '/signIn';
  static const HomeScreen = '/home';

  static String get initialRoute => GetStorage().hasData(kAccessToken)? HomeScreen : SignInScreen;
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
  GetPage(
    name: RouteNames.SignInScreen,
    page: () => SignInScreen(),
  ),
  GetPage(
    name: RouteNames.HomeScreen,
    page: () => HomeScreen(),
  ),
];