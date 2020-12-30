import 'dart:ui';
import 'package:flutter_study/config/lang.dart';
import 'package:get/get.dart';

class LangController extends GetxController {
  var lang = L.locales.keys.first;

  void changeLocale(String _lang) => Get.updateLocale(_findLocale(_lang));

  Locale _findLocale(String _lang) {
    if (L.locales.containsKey(_lang)) {
      lang = _lang;

      return _lang.toLocale();
    }
    return Get.locale;
  }
}
extension LocaleString on String{
  Locale toLocale(){
    final arr = split('_');
    return Locale(arr[0], arr[1]);
  }
}