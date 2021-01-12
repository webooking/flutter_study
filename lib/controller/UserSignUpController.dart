import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserSignUpController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final email = ''.obs;
  final password = ''.obs;
  final hidePassword = true.obs;

  final confirmPassword = ''.obs;
  final hideConfirmPassword = true.obs;

  void submit(){
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      Get.toNamed<void>(RouteNames.CompleteProfileScreen);
    }
  }
}