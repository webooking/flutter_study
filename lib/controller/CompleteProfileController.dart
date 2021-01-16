import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompleteProfileController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final firstName = ''.obs;
  final lastName = ''.obs;
  final phone = ''.obs;
  final location = ''.obs;

  void submit(){
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      Get.toNamed<dynamic>(RouteNames.OtpScreen, arguments: phone.value);
    }
  }
}