import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OtpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final otpCodes = <int,int>{
    0: null,
    1: null,
    2: null,
    3: null,
  }.obs;

  final focusNodes = {
    1: FocusNode(debugLabel: '1'),
    2: FocusNode(debugLabel: '2'),
    3: FocusNode(debugLabel: '3'),
  };

  void next(int index) {
    final nextIndex = index + 1;
    focusNodes.forEach((key, value) {
      if (key == nextIndex) {
        value.requestFocus();
      } else {
        value.unfocus();
      }
    });
  }

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      GetStorage().write(kAccessToken, 'a03c3b36-5259-11eb-ae93-0242ac130002');

      Get.offAllNamed<void>(RouteNames.HomeScreen);
    }
  }
}
