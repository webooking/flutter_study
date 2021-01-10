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
          'signIn.greet.appBar': 'Sign in',
          'signIn.greet.title': 'Welcome Back',
          'signIn.greet.subtitle': 'Sign in with your email and password',
          'signIn.btn': 'SignIn',
          'signIn.email.labelText': 'Email',
          'signIn.email.hintText': 'Your Email',
          'signIn.email.valid.empty': 'email cannot be empty',
          'signIn.email.valid.format': 'email format error',
          'signIn.password.labelText': 'Password',
          'signIn.password.hintText': 'Your Password',
          'signIn.password.valid.empty': 'password cannot be empty',
          'signIn.password.valid.format': '''1. Minimum 1 Upper case
2. Minimum 1 lowercase
3. Minimum 1 Numeric Number
4. Minimum 1 Special Character(! @ # \$ & * ~ )
5. Allow [6,16] characters''',
          'signIn.hint.forgetPassword': 'Forget password?',
          'signIn.hint.noAccount': 'Does not have account?',
          'signIn.hint.signUp': 'Sign Up',
        },
        'zh_CN': {
          'button.bt_continue': '马上体验',
          'signIn.greet.appBar': '登录',
          'signIn.greet.title': '欢迎使用',
          'signIn.greet.subtitle': '请使用邮箱和密码登录',
          'signIn.btn': '登录',
          'signIn.email.labelText': '邮箱',
          'signIn.email.hintText': '请输入您的邮箱',
          'signIn.email.valid.empty': '邮箱不能为空',
          'signIn.email.valid.format': '邮箱格式错误',
          'signIn.password.labelText': '密码',
          'signIn.password.hintText': '请输入密码',
          'signIn.password.valid.empty': '密码不能为空',
          'signIn.password.valid.format': '''1. 至少一个大写字母
2. 至少一个小写字母
3. 至少一个数字
4. 至少一个特殊字符(! @ # \$ & * ~ )
5. 允许输入[6,16]个字符''',
          'signIn.hint.forgetPassword': '忘记密码？',
          'signIn.hint.noAccount': '还没有账号？',
          'signIn.hint.signUp': '注册',
        }
      };
  static L_button get button => L_button();
  static L_signIn get signIn => L_signIn();
}
class L_signIn{
  static final L_signIn _singleton = L_signIn._internal();
  factory L_signIn() {
    return _singleton;
  }
  L_signIn._internal();
  L_signIn_greet get greet => L_signIn_greet();
  String get btn => 'signIn.btn'.tr;
  L_signIn_email get email => L_signIn_email();
  L_signIn_password get password => L_signIn_password();
  L_signIn_hint get hint => L_signIn_hint();
}
class L_signIn_hint{
  static final L_signIn_hint _singleton = L_signIn_hint._internal();
  factory L_signIn_hint() {
    return _singleton;
  }
  L_signIn_hint._internal();

  String get forgetPassword => 'signIn.hint.forgetPassword'.tr;
  String get noAccount => 'signIn.hint.noAccount'.tr;
  String get signUp => 'signIn.hint.signUp'.tr;
}
class L_signIn_password{
  static final L_signIn_password _singleton = L_signIn_password._internal();
  factory L_signIn_password() {
    return _singleton;
  }
  L_signIn_password._internal();
  L_signIn_password_valid get valid => L_signIn_password_valid();

  String get labelText => 'signIn.password.labelText'.tr;
  String get hintText => 'signIn.password.hintText'.tr;
}
class L_signIn_password_valid{
  static final L_signIn_password_valid _singleton = L_signIn_password_valid._internal();
  factory L_signIn_password_valid() {
    return _singleton;
  }
  L_signIn_password_valid._internal();
  String get empty => 'signIn.password.valid.empty'.tr;
  String get format => 'signIn.password.valid.format'.tr;
}
class L_signIn_email{
  static final L_signIn_email _singleton = L_signIn_email._internal();
  factory L_signIn_email() {
    return _singleton;
  }
  L_signIn_email._internal();
  L_signIn_email_valid get valid => L_signIn_email_valid();

  String get labelText => 'signIn.email.labelText'.tr;
  String get hintText => 'signIn.email.hintText'.tr;
}
class L_signIn_email_valid{
  static final L_signIn_email_valid _singleton = L_signIn_email_valid._internal();
  factory L_signIn_email_valid() {
    return _singleton;
  }
  L_signIn_email_valid._internal();
  String get empty => 'signIn.email.valid.empty'.tr;
  String get format => 'signIn.email.valid.format'.tr;
}
class L_signIn_greet{
  static final L_signIn_greet _singleton = L_signIn_greet._internal();
  factory L_signIn_greet() {
    return _singleton;
  }
  L_signIn_greet._internal();
  String get appBar => 'signIn.greet.appBar'.tr;
  String get title => 'signIn.greet.title'.tr;
  String get subtitle => 'signIn.greet.subtitle'.tr;
}
class L_button {
  static final L_button _singleton = L_button._internal();
  factory L_button() {
    return _singleton;
  }
  L_button._internal();
  String get bt_continue => 'button.bt_continue'.tr;
}

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
