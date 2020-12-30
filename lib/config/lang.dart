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
        },
        'zh_CN': {
          'hello': '你好！',
          'greet': '你好 {{firstName}}',
          'date.picker': '选择日期',
        },
      };

  static String get hello => 'hello'.tr;
  static String greet(String firstName) => 'greet'.trMap({
        'firstName': firstName,
      });
  static L_Date get date => L_Date();
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
