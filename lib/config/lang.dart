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
