abstract class RegexUtil{
  static final emailRegex = RegExp(r'^([a-z0-9A-Z]+[-|\.|_]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-zA-Z]{2,}$');
  static final passwordRegex = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,16}$');
}