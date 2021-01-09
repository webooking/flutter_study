import 'package:get/get.dart';

class S {
  static final double _templateWidth = 428.0;
  static final double _templateHeight = 926.0;

  static double x(double inputWidth) => inputWidth / _templateWidth * Get.width;
  static double y(double inputHeight) => inputHeight / _templateHeight * Get.height;
}
