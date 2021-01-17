import 'package:flutter_study/controller/CompleteProfileController.dart';
import 'package:flutter_study/controller/CounterController.dart';
import 'package:flutter_study/controller/OtpController.dart';
import 'package:flutter_study/controller/UserSignInController.dart';
import 'package:flutter_study/controller/UserSignUpController.dart';
import 'package:flutter_study/screen/SplashScreen.dart';
import 'package:flutter_study/screen/counter/counter_child_screen.dart';
import 'package:flutter_study/screen/counter/counter_screen.dart';
import 'package:flutter_study/screen/home/HomeScreen.dart';
import 'package:flutter_study/screen/signIn/SignInScreen.dart';
import 'package:flutter_study/screen/signUp/SignUpScreen.dart';
import 'package:flutter_study/screen/signUp/complete/CompleteProfileScreen.dart';
import 'package:flutter_study/screen/signUp/complete/otp/OtpScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class RouteNames {
  static const CounterScreen = '/counter';
  static const CounterChildScreen = '/counter/child';
  static const SplashScreen = '/splash';
  static const SignInScreen = '/signIn';

  //--signUp---
  static const SignUpScreen = '/signUp';
  static const CompleteProfileScreen = '/signUp/complete/profile';
  static const OtpScreen = '/signUp/complete/profile/otp';

  static const HomeScreen = '/home';

  static String get initialRoute => GetStorage().hasData('accessToken')? HomeScreen : SplashScreen;
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
    binding: BindingsBuilder<UserSignInController>(() => Get.lazyPut(() => UserSignInController())),
  ),
  GetPage(
    name: RouteNames.HomeScreen,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: RouteNames.SignUpScreen,
    page: () => SignUpScreen(),
    binding: BindingsBuilder<UserSignUpController>(() => Get.lazyPut(() => UserSignUpController())),
    children: [
      GetPage(
        name: '/complete/profile',
        page: () => CompleteProfileScreen(),
        binding: BindingsBuilder<CompleteProfileController>(() => Get.lazyPut(() => CompleteProfileController())),
        children: [
          GetPage(
            name: '/otp',
            page: () => OtpScreen(
              phone: Get.arguments as String
            ),
            binding: BindingsBuilder<OtpController>(() => Get.lazyPut(() => OtpController())),
          ),
        ],
      ),
    ],
  ),

];