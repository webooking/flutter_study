import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSignInController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final email = ''.obs;
  final password = ''.obs;
}