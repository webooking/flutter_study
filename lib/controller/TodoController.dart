import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
