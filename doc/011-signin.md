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

## 3.1 theme

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

## 3.2 GlobalKey

这里的`Form`与html原理相同，需要指定`key`

```
Form(
 key: controller.formKey,
)

void signIn(){
  if(formKey.currentState.validate()){//校验多个TextFormField：email,password
    formKey.currentState.save();
    GetStorage().write(kAccessToken, 'a03c3b36-5259-11eb-ae93-0242ac130002');
    Get.offAllNamed<void>(RouteNames.HomeScreen);
  }
}
```

## 3.3 TextFormField

```
TextFormField(
  keyboardType: TextInputType.emailAddress,
  onSaved: (newValue) => controller.email.value = newValue,
  validator: (value) {
    if (value.isEmpty) {
      return 'email cannot be empty';
    }
    return null;
  },
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Your E-Mail',
    floatingLabelBehavior: FloatingLabelBehavior.always,
    prefixIcon: Icon(Icons.email),
  ),
);
```

# 4 Source code

## 4.1 SignInScreen

```

import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/screen/signIn/SignInForm.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('Welcome Back',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Text('Sign in with your email and password'),
            SizedBox(height: S.y(50)),
            SignInForm(),
          ],
        ),
      ),
    );
  }

}
```



## 4.2 SignInForm

```
import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/RegexUtil.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/UserSignInController.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserSignInController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _emailFormField(controller),
            SizedBox(height: S.y(30)),
            Obx(() => _passwordFormField(controller)),
            SizedBox(height: S.y(20)),
            Text(
              'Forget password?',
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: S.y(30)),
            DefaultButton(
              text: 'SignIn',
              press: () => controller.signIn(),
            ),
            SizedBox(height: S.y(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Does not have account?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: S.x(20)),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18,
                    color: kPrimaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _passwordFormField(UserSignInController controller) => TextFormField(
        obscureText: controller.hidePassword.value,
        onSaved: (newValue) => controller.password.value = newValue,
        validator: (value) {
          if (value.isEmpty) {
            return 'password cannot be empty';
          } else if (!RegexUtil.passwordRegex.hasMatch(value)) {
            return '''1. Minimum 1 Upper case
2. Minimum 1 lowercase
3. Minimum 1 Numeric Number
4. Minimum 1 Special Character(! @ # \$ & * ~ )
5. [6,16] characters''';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Your Password',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon: Icon(controller.hidePassword.value ? Icons.remove_red_eye: Icons.remove_red_eye_outlined),
            onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
          ),
        ),
      );
  TextFormField _emailFormField(UserSignInController controller) => TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => controller.email.value = newValue,
        validator: (value) {
          if (value.isEmpty) {
            return 'email cannot be empty';
          } else if (!RegexUtil.emailRegex.hasMatch(value)) {
            return 'email format error';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Your E-Mail',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(Icons.email),
        ),
      );
}
```

# 5 preview

![image-20210109194848613](/image-20210109194848613.png)

