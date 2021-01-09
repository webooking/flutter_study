import 'dart:ui';

import 'package:get/get.dart';

class L extends Translations {
  static final locales = {
    'en_US': 'English',
    'zh_CN': '简体中文',
  };
  static final defaultLocale = window.locale;
  static final fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'button.bt_continue': 'Continue',
          'hello': 'hello!',
          'notice': '''This is  
a multiline 
example.''',
          'greet': 'Hello {{firstName}}!',
          'date.picker': 'select date',
          'product.online.item.Zero': 'There are no items',
          'product.online.item.One': 'There is 1 item',
          'product.online.item.More': 'There are {{count}} items',
          'user.contact.Male': 'Hi,Mr {{lastName}}',
          'user.contact.Female': 'Hi,Mrs {{lastName}}',
          'product.instock': 'surplus goods {{count}}'
        },
        'zh_CN': {
          'button.bt_continue': '马上体验',
          'hello': '你好！',
          'notice': '''这是  
一个  
多行文本的例子。''',
          'greet': '你好{{firstName}}！',
          'date.picker': '选择日期',
          'product.online.item.Zero': '没有数据',
          'product.online.item.One': '{{count}}条数据',
          'product.online.item.More': '{{count}}条数据',
          'user.contact.Male': '{{lastName}}{{firstName}}先生，您好',
          'user.contact.Female': '{{lastName}}女士，您好',
          'product.instock': '库存{{count}}'
        }
      };
  static L_button get button => L_button();
  static String get hello => 'hello'.tr;
  static String get notice => 'notice'.tr;
  static String greet(
    String firstName,
  ) =>
      'greet'.trMap({
        'firstName': firstName,
      });
  static L_date get date => L_date();
  static L_user get user => L_user();
  static L_product get product => L_product();
}

class L_button {
  static final L_button _singleton = L_button._internal();
  factory L_button() {
    return _singleton;
  }
  L_button._internal();
  String get bt_continue => 'button.bt_continue'.tr;
}

class L_date {
  static final L_date _singleton = L_date._internal();
  factory L_date() {
    return _singleton;
  }
  L_date._internal();
  String get picker => 'date.picker'.tr;
}

class L_user {
  static final L_user _singleton = L_user._internal();
  factory L_user() {
    return _singleton;
  }
  L_user._internal();
  String contact(
    Gender gender,
    String lastName,
    String firstName,
  ) {
    if (gender == Gender.Male) {
      return 'user.contact.Male'.trMap({
        'gender': gender.toString(),
        'lastName': lastName,
        'firstName': firstName,
      });
    }
    if (gender == Gender.Female) {
      return 'user.contact.Female'.trMap({
        'gender': gender.toString(),
        'lastName': lastName,
        'firstName': firstName,
      });
    }
  }
}

class L_product {
  static final L_product _singleton = L_product._internal();
  factory L_product() {
    return _singleton;
  }
  L_product._internal();
  String instock(
    int count,
  ) =>
      'product.instock'.trMap({
        'count': count.toString(),
      });
  L_product_online get online => L_product_online();
}

class L_product_online {
  static final L_product_online _singleton = L_product_online._internal();
  factory L_product_online() {
    return _singleton;
  }
  L_product_online._internal();
  String item(
    int count,
  ) {
    if (count == 0) {
      return 'product.online.item.Zero'.trMap({
        'count': count.toString(),
      });
    } else if (count == 1) {
      return 'product.online.item.One'.trMap({
        'count': count.toString(),
      });
    } else {
      return 'product.online.item.More'.trMap({
        'count': count.toString(),
      });
    }
  }
}

enum Gender { Male, Female }

extension CustomTrans on String {
  String trMap(Map<String, String> map) {
    var text = tr;
    map.forEach((key, value) {
      if (value != null) {
        text = text.replaceAll('{{${key}}}', value);
      }
    });
    return text;
  }
}
