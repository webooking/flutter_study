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

## 5.3 custom i18n extension

参考的项目：`flutter_sheet_localization_generator`,`i18n`

### 5.3.1 template

| Key                    | (Comments)                                                   | en_US                                    | zh_CN                                  |
| ---------------------- | ------------------------------------------------------------ | ---------------------------------------- | -------------------------------------- |
| hello                  | plain text                                                   | hello!                                   | 你好！                                 |
| notice                 | 通常用于公告信息，比如，<br />发布新版本app时的通知，优惠活动等 | This is <br />a  multiline<br />example. | 这是<br /> 一个 <br />多行文本的例子。 |
| greet                  | text with parameters                                         | Hello {{firstName}}!                     | 你好{{firstName}}！                    |
| date.picker            |                                                              | select date                              | 选择日期                               |
| item(Plural.zero)      | plural                                                       | There are no items                       | 没有数据                               |
| item(Plural.one)       |                                                              | There is 1 item                          | {{count}}条数据                        |
| item(Plural.more)      |                                                              | There are {{count}} items                | {{count}}条数据                        |
| contact(Gender.male)   | enumeration                                                  | Mr {{lastName}}                          | {{lastName}}先生                       |
| contact(Gender.female) |                                                              | Mrs {{lastName}}                         | {{lastName}}女士                       |

![image-20210101001042102](/image-20210101001042102.png)

### 5.3.2 dart-i18n-template-code

```
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
          'greet': 'Hello {{firstName}}',
          'date.picker': 'select date',
          'notice': '''This is 
a  multiline 
example.''',
          'item.zero': 'There are no items',
          'item.one': 'There is {{count}} item',
          'item.more': 'There are {{count}} items',
          'contact.male': 'Mr {{lastName}}',
          'contact.female': 'Mrs {{lastName}}',
        },
        'zh_CN': {
          'hello': '你好！',
          'greet': '你好 {{firstName}}',
          'date.picker': '选择日期',
          'notice': '''这是
一个
多行文本。''',
          'item.zero': '没有数据',
          'item.one': '{{count}}条数据',
          'item.more': '{{count}}条数据',
          'contact.male': '{{lastName}}先生',
          'contact.female': '{{lastName}}女士',
        },
      };

  static String get hello => 'hello'.tr;
  static String get notice => 'notice'.tr;
  static String greet(String firstName) => 'greet'.trMap({
        'firstName': firstName,
      });
  static L_Date get date => L_Date();

  static String item(int count) {
    if (count == 0) {
      return 'item.zero'.tr;
    } else if (count == 1) {
      return 'item.one'.trMap({
        'count': count.toString(),
      });
    } else {
      return 'item.more'.trMap({
        'count': count.toString(),
      });
    }
  }

  static String contact(Gender gender, String lastName) {
    if (gender == Gender.Male) {
      return 'contact.male'.trMap({'lastName': lastName});
    } else {
      return 'contact.female'.trMap({'lastName': lastName});
    }
  }
}

final templateRegExp = RegExp(r'\{\{(\w+)\}\}');

extension CustomTrans on String {
  String trMap(Map<String, String> map) {
    var text = tr; // 'Hello {{firstName}}' || '你好 {{firstName}}'
    templateRegExp.allMatches(text).map((e) => e.group(1)).forEach((element) {
      text = text.replaceAll('{{${element}}}', map[element]);
    });
    return text;
  }
}

class L_Date {
  String get picker => 'date.picker'.tr;
}

enum Gender { Male, Female }

```



### 5.3.3 parse csv to dart-i18n-template-code

![image-20210103022349117](/image-20210103022349117.png)



![image-20210105020311242](/image-20210105020311242.png)





