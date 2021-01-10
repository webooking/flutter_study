import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserSignInController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final email = ''.obs;
  final password = ''.obs;
  final hidePassword = true.obs;

  void signIn(){
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      GetStorage().write(kAccessToken, 'a03c3b36-5259-11eb-ae93-0242ac130002');
      Get.offAllNamed<void>(RouteNames.HomeScreen);
    }
  }
}