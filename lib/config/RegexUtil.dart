abstract class RegexUtil{
  static final email = RegExp(r'^([a-z0-9A-Z]+[-|\.|_]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-zA-Z]{2,}$');
  static final password = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,16}$');
  static final phone = RegExp(r'^\d{10,11}$');

}