---
typora-root-url: ./assets
---

#  1 brief profile

![image-20210109112017246](/image-20210109112017246.png)

![image-20210109004557889](/image-20210109004557889.png)



# 2 accessToken

![image-20210109113034327](/image-20210109113034327.png)



## 2.1 dependency

```
get_storage: ^1.4.0
```

## 2.2 dynamic route

### 2.2.1 main.dart

 ```
Future<void> main() async {
  await GetStorage.init();

  runApp(GetMaterialApp(
    ...
    initialRoute: RouteNames.initialRoute,
  ));
}
 ```

### 2.2.2 routes.dart

```
abstract class RouteNames {
  ...
  static const SignInScreen = '/signIn';
  static const HomeScreen = '/home';

  static String get initialRoute => GetStorage().hasData(kAccessToken)? HomeScreen : SignInScreen;
}

final pages = [
  ...
  GetPage(
    name: RouteNames.SignInScreen,
    page: () => SignInScreen(),
  ),
  GetPage(
    name: RouteNames.HomeScreen,
    page: () => HomeScreen(),
  ),
];
```

### 2.2.3 HomeScreen

```
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('welcome to hooray'),
            Spacer(flex: 2,),
            DefaultButton(
              text: 'clear storage',
              press: () => GetStorage().erase(),
            ),
            Spacer(),
            DefaultButton(
              text: 'close app',
              press: () => exit(0),
            ),
            Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }
}
```

### 2.2.4 SignInScreen

```
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:get_storage/get_storage.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign in with your email and password'),
            Spacer(flex: 2,),
            DefaultButton(
              text: 'Simulation signIn is successful',
              press: () => GetStorage().write('accessToken', 'a03c3b36-5259-11eb-ae93-0242ac130002'),
            ),
            Spacer(),
            DefaultButton(
              text: 'close app',
              press: () => exit(0),
            ),
            Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }
}

```



# 3 TextFormField & Form





# 4 config

## 4.1 theme

- appbar
- text
- input textfield

```
import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: _appBarTheme(),
    textTheme: _textTheme(),
    inputDecorationTheme: _inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme _inputDecorationTheme() {
  final outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme _textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}
```

## 4.2 GlobalKey

