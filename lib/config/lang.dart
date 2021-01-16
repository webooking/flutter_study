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
          'signIn.appBar': 'Sign in',
          'signIn.title': 'Welcome Back',
          'signIn.subtitle': 'Sign in with your email and password',
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
          'signIn.hint.forgotPassword': 'Forgot password?',
          'signIn.hint.noAccount': 'Does not have account?',
          'signIn.hint.signUp': 'Sign Up',
          'signUp.appBar': 'Sign up',
          'signUp.title': 'Register Account',
          'signUp.subtitle': 'Complete your details',
          'signUp.btn': 'Continue',
          'signUp.email.labelText': 'Email',
          'signUp.email.hintText': 'Your Email',
          'signUp.email.valid.empty': 'email cannot be empty',
          'signUp.email.valid.format': 'email format error',
          'signUp.password.labelText': 'Password',
          'signUp.password.hintText': 'Your Password',
          'signUp.password.valid.empty': 'password cannot be empty',
          'signUp.password.valid.format': '''1. Minimum 1 Upper case
2. Minimum 1 lowercase
3. Minimum 1 Numeric Number
4. Minimum 1 Special Character(! @ # \$ & * ~ )
5. Allow [6,16] characters''',
          'signUp.confirmPassword.labelText': 'Confirm Password',
          'signUp.confirmPassword.hintText': 'Re-Enter Your Password',
          'signUp.confirmPassword.valid.empty': 'password cannot be empty',
          'signUp.confirmPassword.valid.format': '''1. Minimum 1 Upper case
2. Minimum 1 lowercase
3. Minimum 1 Numeric Number
4. Minimum 1 Special Character(! @ # \$ & * ~ )
5. Allow [6,16] characters''',
          'signUp.confirmPassword.valid.notEqual': 'The code you enter twice must be the same',
          'signUp.completeProfile.title': 'Complete Profile',
          'signUp.completeProfile.btn': 'Continue',

          'signUp.completeProfile.firstName.labelText': 'First Name',
          'signUp.completeProfile.firstName.hintText': 'Enter Your First Name',
          'signUp.completeProfile.firstName.valid.empty': 'First Name cannot be empty',

          'signUp.completeProfile.lastName.labelText': 'Last Name',
          'signUp.completeProfile.lastName.hintText': 'Enter Your last name',
          'signUp.completeProfile.lastName.valid.empty': 'Last Name cannot be empty',

          'signUp.completeProfile.location.labelText': 'Location',
          'signUp.completeProfile.location.hintText': 'Enter Your location',
          'signUp.completeProfile.location.valid.empty': 'location cannot be empty',

          'signUp.completeProfile.phone.labelText': 'Phone Number',
          'signUp.completeProfile.phone.hintText': 'Enter Your Phone Number',
          'signUp.completeProfile.phone.valid.empty': 'Phone Number cannot be empty',
          'signUp.completeProfile.phone.valid.format': 'Phone Number format error',
          'signUp.otp.title': 'OTP Verification',
          'signUp.otp.hint': 'We sent your code to +1 {{phone}}',
          'signUp.otp.expired.prefix': 'This code will expired in ',
          'signUp.otp.expired.suffix': 's',
          'signUp.otp.resent': 'Resent OTP Code',
          'signUp.otp.valid.empty': 'OTP Code cannot be empty',
          'signUp.otp.valid.format': 'OTP Code must be number',
        },
        'zh_CN': {
          'button.bt_continue': '马上体验',
          'signIn.appBar': '登录',
          'signIn.title': '欢迎使用',
          'signIn.subtitle': '请使用邮箱和密码登录',
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
          'signIn.hint.forgotPassword': '忘记密码？',
          'signIn.hint.noAccount': '还没有账号？',
          'signIn.hint.signUp': '注册',
          'signUp.appBar': '注册',
          'signUp.title': '注册新用户',
          'signUp.subtitle': '请填写您的详细信息',
          'signUp.btn': '下一步',
          'signUp.email.labelText': '邮箱',
          'signUp.email.hintText': '请输入您的邮箱',
          'signUp.email.valid.empty': '邮箱不能为空',
          'signUp.email.valid.format': '邮箱格式错误',
          'signUp.password.labelText': '密码',
          'signUp.password.hintText': '请输入密码',
          'signUp.password.valid.empty': '密码不能为空',
          'signUp.password.valid.format': '''1. 至少一个大写字母
2. 至少一个小写字母
3. 至少一个数字
4. 至少一个特殊字符(! @ # \$ & * ~ )
5. 允许输入[6,16]个字符''',
          'signUp.confirmPassword.labelText': '确认密码',
          'signUp.confirmPassword.hintText': '请重新输入密码',
          'signUp.confirmPassword.valid.empty': '密码不能为空',
          'signUp.confirmPassword.valid.format': '''1. 至少一个大写字母
2. 至少一个小写字母
3. 至少一个数字
4. 至少一个特殊字符(! @ # \$ & * ~ )
5. 允许输入[6,16]个字符''',
          'signUp.confirmPassword.valid.notEqual': '两次输入的密码必须一致',
          'signUp.completeProfile.title': '完善您的信息',
          'signUp.completeProfile.btn': '下一步',

          'signUp.completeProfile.firstName.labelText': '姓氏',
          'signUp.completeProfile.firstName.hintText': '请输入您的姓氏',
          'signUp.completeProfile.firstName.valid.empty': '姓氏不能为空',

          'signUp.completeProfile.lastName.labelText': '名字',
          'signUp.completeProfile.lastName.hintText': '请输入您的名字',
          'signUp.completeProfile.lastName.valid.empty': '名字不能为空',

          'signUp.completeProfile.location.labelText': '地址',
          'signUp.completeProfile.location.hintText': '请输入您的家庭地址',
          'signUp.completeProfile.location.valid.empty': '地址不能为空',

          'signUp.completeProfile.phone.labelText': '手机号',
          'signUp.completeProfile.phone.hintText': '请输入您的手机号',
          'signUp.completeProfile.phone.valid.empty': '手机号不能为空',
          'signUp.completeProfile.phone.valid.format': '手机号格式错误',
          'signUp.otp.title': '验证OTP',
          'signUp.otp.hint': '验证码已发送到 +1 {{phone}}',
          'signUp.otp.expired.prefix': '',
          'signUp.otp.expired.suffix': '秒后过期',
          'signUp.otp.resent': '重新发送验证码',
          'signUp.otp.valid.empty': 'OTP不能为空',
          'signUp.otp.valid.format': '必须是数字',
        }
      };
  static L_button get button => L_button();
  static L_signIn get signIn => L_signIn();
  static L_signUp get signUp => L_signUp();
}

class L_signUp {
  static final L_signUp _singleton = L_signUp._internal();
  factory L_signUp() {
    return _singleton;
  }
  L_signUp._internal();
  String get btn => 'signUp.btn'.tr;
  String get appBar => 'signUp.appBar'.tr;
  String get title => 'signUp.title'.tr;
  String get subtitle => 'signUp.subtitle'.tr;

  L_signUp_otp get otp => L_signUp_otp();
  L_signUp_email get email => L_signUp_email();
  L_signUp_password get password => L_signUp_password();
  L_signUp_confirmPassword get confirmPassword => L_signUp_confirmPassword();
  L_signUp_completeProfile get completeProfile => L_signUp_completeProfile();
}
class L_signUp_otp {
  static final L_signUp_otp _singleton = L_signUp_otp._internal();
  factory L_signUp_otp() {
    return _singleton;
  }
  L_signUp_otp._internal();

  String get title => 'signUp.otp.title'.tr;
  String get resent => 'signUp.otp.resent'.tr;

  String hint(String phone) => 'signUp.otp.hint'.trMap({
    'phone': phone,
  });

  L_signUp_otp_expired get expired => L_signUp_otp_expired();
  L_signUp_otp_valid get valid => L_signUp_otp_valid();

}
class L_signUp_otp_valid {
  static final L_signUp_otp_valid _singleton = L_signUp_otp_valid._internal();

  factory L_signUp_otp_valid() {
    return _singleton;
  }
  L_signUp_otp_valid._internal();

  String get empty => 'signUp.otp.valid.empty'.tr;
  String get format => 'signUp.otp.valid.format'.tr;
}
class L_signUp_otp_expired {
  static final L_signUp_otp_expired _singleton = L_signUp_otp_expired._internal();

  factory L_signUp_otp_expired() {
    return _singleton;
  }
  L_signUp_otp_expired._internal();

  String get prefix => 'signUp.otp.expired.prefix'.tr;
  String get suffix => 'signUp.otp.expired.suffix'.tr;
}
class L_signUp_completeProfile {
  static final L_signUp_completeProfile _singleton = L_signUp_completeProfile._internal();
  factory L_signUp_completeProfile() {
    return _singleton;
  }
  L_signUp_completeProfile._internal();

  String get title => 'signUp.completeProfile.title'.tr;
  String get btn => 'signUp.completeProfile.btn'.tr;

  L_signUp_completeProfile_firstName get firstName => L_signUp_completeProfile_firstName();
  L_signUp_completeProfile_lastName get lastName => L_signUp_completeProfile_lastName();
  L_signUp_completeProfile_location get location => L_signUp_completeProfile_location();
  L_signUp_completeProfile_phone get phone => L_signUp_completeProfile_phone();
}
class L_signUp_completeProfile_phone {
  static final L_signUp_completeProfile_phone _singleton = L_signUp_completeProfile_phone._internal();
  factory L_signUp_completeProfile_phone() {
    return _singleton;
  }
  L_signUp_completeProfile_phone._internal();

  String get labelText => 'signUp.completeProfile.phone.labelText'.tr;
  String get hintText => 'signUp.completeProfile.phone.hintText'.tr;

  L_signUp_completeProfile_phone_valid get valid => L_signUp_completeProfile_phone_valid();
}
class L_signUp_completeProfile_phone_valid {
  static final L_signUp_completeProfile_phone_valid _singleton = L_signUp_completeProfile_phone_valid._internal();
  factory L_signUp_completeProfile_phone_valid() {
    return _singleton;
  }
  L_signUp_completeProfile_phone_valid._internal();

  String get empty => 'signUp.completeProfile.phone.valid.empty'.tr;
  String get format => 'signUp.completeProfile.phone.valid.format'.tr;
}

class L_signUp_completeProfile_location {
  static final L_signUp_completeProfile_location _singleton = L_signUp_completeProfile_location._internal();
  factory L_signUp_completeProfile_location() {
    return _singleton;
  }
  L_signUp_completeProfile_location._internal();

  String get labelText => 'signUp.completeProfile.location.labelText'.tr;
  String get hintText => 'signUp.completeProfile.location.hintText'.tr;

  L_signUp_completeProfile_lastName_valid get valid => L_signUp_completeProfile_lastName_valid();
}
class L_signUp_completeProfile_location_valid {
  static final L_signUp_completeProfile_location_valid _singleton = L_signUp_completeProfile_location_valid._internal();
  factory L_signUp_completeProfile_location_valid() {
    return _singleton;
  }
  L_signUp_completeProfile_location_valid._internal();

  String get empty => 'signUp.completeProfile.location.valid.empty'.tr;
}

class L_signUp_completeProfile_lastName {
  static final L_signUp_completeProfile_lastName _singleton = L_signUp_completeProfile_lastName._internal();
  factory L_signUp_completeProfile_lastName() {
    return _singleton;
  }
  L_signUp_completeProfile_lastName._internal();

  String get labelText => 'signUp.completeProfile.lastName.labelText'.tr;
  String get hintText => 'signUp.completeProfile.lastName.hintText'.tr;

  L_signUp_completeProfile_lastName_valid get valid => L_signUp_completeProfile_lastName_valid();
}
class L_signUp_completeProfile_lastName_valid {
  static final L_signUp_completeProfile_lastName_valid _singleton = L_signUp_completeProfile_lastName_valid._internal();
  factory L_signUp_completeProfile_lastName_valid() {
    return _singleton;
  }
  L_signUp_completeProfile_lastName_valid._internal();

  String get empty => 'signUp.completeProfile.lastName.valid.empty'.tr;
}

class L_signUp_completeProfile_firstName {
  static final L_signUp_completeProfile_firstName _singleton = L_signUp_completeProfile_firstName._internal();
  factory L_signUp_completeProfile_firstName() {
    return _singleton;
  }
  L_signUp_completeProfile_firstName._internal();

  String get labelText => 'signUp.completeProfile.firstName.labelText'.tr;
  String get hintText => 'signUp.completeProfile.firstName.hintText'.tr;

  L_signUp_completeProfile_firstName_valid get valid => L_signUp_completeProfile_firstName_valid();
}
class L_signUp_completeProfile_firstName_valid {
  static final L_signUp_completeProfile_firstName_valid _singleton = L_signUp_completeProfile_firstName_valid._internal();
  factory L_signUp_completeProfile_firstName_valid() {
    return _singleton;
  }
  L_signUp_completeProfile_firstName_valid._internal();

  String get empty => 'signUp.completeProfile.firstName.valid.empty'.tr;
}
class L_signUp_confirmPassword {
  static final L_signUp_confirmPassword _singleton = L_signUp_confirmPassword._internal();
  factory L_signUp_confirmPassword() {
    return _singleton;
  }
  L_signUp_confirmPassword._internal();

  String get labelText => 'signUp.confirmPassword.labelText'.tr;
  String get hintText => 'signUp.confirmPassword.hintText'.tr;

  L_signUp_confirmPassword_valid get valid => L_signUp_confirmPassword_valid();
}

class L_signUp_confirmPassword_valid {
  static final L_signUp_confirmPassword_valid _singleton = L_signUp_confirmPassword_valid._internal();
  factory L_signUp_confirmPassword_valid() {
    return _singleton;
  }
  L_signUp_confirmPassword_valid._internal();

  String get empty => 'signUp.confirmPassword.valid.empty'.tr;
  String get format => 'signUp.confirmPassword.valid.format'.tr;
  String get notEqual => 'signUp.confirmPassword.valid.notEqual'.tr;
}

class L_signUp_password {
  static final L_signUp_password _singleton = L_signUp_password._internal();
  factory L_signUp_password() {
    return _singleton;
  }
  L_signUp_password._internal();

  String get labelText => 'signUp.password.labelText'.tr;
  String get hintText => 'signUp.password.hintText'.tr;

  L_signUp_password_valid get valid => L_signUp_password_valid();
}

class L_signUp_password_valid {
  static final L_signUp_password_valid _singleton = L_signUp_password_valid._internal();
  factory L_signUp_password_valid() {
    return _singleton;
  }
  L_signUp_password_valid._internal();

  String get empty => 'signUp.password.valid.empty'.tr;
  String get format => 'signUp.password.valid.format'.tr;
}

class L_signUp_email {
  static final L_signUp_email _singleton = L_signUp_email._internal();
  factory L_signUp_email() {
    return _singleton;
  }
  L_signUp_email._internal();

  String get labelText => 'signUp.email.labelText'.tr;
  String get hintText => 'signUp.email.hintText'.tr;
  L_signUp_email_valid get valid => L_signUp_email_valid();
}

class L_signUp_email_valid {
  static final L_signUp_email_valid _singleton = L_signUp_email_valid._internal();
  factory L_signUp_email_valid() {
    return _singleton;
  }
  L_signUp_email_valid._internal();

  String get empty => 'signUp.email.valid.empty'.tr;
  String get format => 'signUp.email.valid.format'.tr;
}

class L_signIn {
  static final L_signIn _singleton = L_signIn._internal();
  factory L_signIn() {
    return _singleton;
  }
  L_signIn._internal();

  String get btn => 'signIn.btn'.tr;
  String get appBar => 'signIn.appBar'.tr;
  String get title => 'signIn.title'.tr;
  String get subtitle => 'signIn.subtitle'.tr;

  L_signIn_email get email => L_signIn_email();
  L_signIn_password get password => L_signIn_password();
  L_signIn_hint get hint => L_signIn_hint();
}

class L_signIn_hint {
  static final L_signIn_hint _singleton = L_signIn_hint._internal();
  factory L_signIn_hint() {
    return _singleton;
  }
  L_signIn_hint._internal();

  String get forgotPassword => 'signIn.hint.forgotPassword'.tr;
  String get noAccount => 'signIn.hint.noAccount'.tr;
  String get signUp => 'signIn.hint.signUp'.tr;
}

class L_signIn_password {
  static final L_signIn_password _singleton = L_signIn_password._internal();
  factory L_signIn_password() {
    return _singleton;
  }
  L_signIn_password._internal();
  L_signIn_password_valid get valid => L_signIn_password_valid();

  String get labelText => 'signIn.password.labelText'.tr;
  String get hintText => 'signIn.password.hintText'.tr;
}

class L_signIn_password_valid {
  static final L_signIn_password_valid _singleton = L_signIn_password_valid._internal();
  factory L_signIn_password_valid() {
    return _singleton;
  }
  L_signIn_password_valid._internal();
  String get empty => 'signIn.password.valid.empty'.tr;
  String get format => 'signIn.password.valid.format'.tr;
}

class L_signIn_email {
  static final L_signIn_email _singleton = L_signIn_email._internal();
  factory L_signIn_email() {
    return _singleton;
  }
  L_signIn_email._internal();
  L_signIn_email_valid get valid => L_signIn_email_valid();

  String get labelText => 'signIn.email.labelText'.tr;
  String get hintText => 'signIn.email.hintText'.tr;
}

class L_signIn_email_valid {
  static final L_signIn_email_valid _singleton = L_signIn_email_valid._internal();
  factory L_signIn_email_valid() {
    return _singleton;
  }
  L_signIn_email_valid._internal();
  String get empty => 'signIn.email.valid.empty'.tr;
  String get format => 'signIn.email.valid.format'.tr;
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
