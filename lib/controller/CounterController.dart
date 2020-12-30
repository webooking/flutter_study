import 'package:get/get.dart';

class CounterController extends GetxController{
  final count = 0.obs;
  void increment() => count.value++;

  void decrement() => count.value--;
}