---
typora-root-url: ./assets
---

# 1 项目结构

<img src="/image-20201225195914865.png" alt="image-20201225195914865" style="zoom:50%;" />

# 2 change app name

| android/app/src/main/AndroidManifest.xml                     | ios/Runner/Info.plist                                        |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `<application>`<br/>  `android:label="your_app_name"`<br/>... | `<key>CFBundleName</key>`<br/>`<string>your_app_name</string>` |



# 3 Change App Launcher Icon

- 准备一张高分辨率的图片。最好是`SVG`
- https://makeappicon.com/
- 解压，并替换相应的文件

![image-20201228000524507](/image-20201228000524507.png)



# 4 重装新版本的app

https://pub.dev/packages/upgrader



# 5 国际化

怎么使用`GetX`实现国际化？

## 5.1 getx

### 5.1.1 config/lang.dart

```dart
import 'dart:ui';
import 'package:get/get.dart';

class L extends Translations {
  static final locales = {
    'en_US': 'English',
    'zh_CN': '简体中文',
  };

  static final defaultLocale = Locale('en', 'US');
  static final fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello!',
        },
        'zh_CN': {
          'hello': '你好！',
        },
      };

  static String get hello => 'hello'.tr;
}
```

### 5.1.2 controller/LangController.dart

```dart
import 'dart:ui';
import 'package:flutter_study/config/lang.dart';
import 'package:get/get.dart';

class LangController extends GetxController {
  var lang = L.locales.keys.first;

  void changeLocale(String _lang) => Get.updateLocale(_findLocale(_lang));

  Locale _findLocale(String _lang) {
    if (L.locales.containsKey(_lang)) {
      lang.value = _lang;

      final arr = _lang.split('_');
      return Locale(arr[0], arr[1]);
    }
    return Get.locale;
  }
}
```

### 5.1.3 screen/lang_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/controller/LangController.dart';
import 'package:get/get.dart';

class LangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LangController>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(L.hello),
            SizedBox(height: 100),
            DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down),
              value: controller.lang,
              items: L.locales.entries.map((entry) =>
                  DropdownMenuItem<String>(value: entry.key, child: Text(entry.value))
              ).toList(),
              onChanged: (String value) {
                controller.changeLocale(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

### 5.1.4 main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:get/get.dart';

import 'config/routes.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    locale: L.defaultLocale,
    fallbackLocale: L.fallbackLocale,
    translations: L(),
    getPages: pages,
    initialRoute: RouteNames.LangScreen,
  ));
}
```

## 5.2 思考

1. `Map<String, Map<String, String>>`结构太复杂了吧...怎么写配置文件呢？json？yaml？要不试试Excel

![example](/example.png)


2. 如何根据配置自动生成模板代码，如下：

```
Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello!',
        },
        'zh_CN': {
          'hello': '你好！',
        },
      };
static String get hello => 'hello'.tr;
```

3. 带参数的消息呢？`Hello {{firstName}}`

## 5.3 flutter_sheet_localization_generator



## 5.4 为什么不使用`intl`













