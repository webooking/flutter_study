import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/RegexUtil.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/UserSignUpController.dart';
import 'package:get/get.dart';

class SignUpForm extends GetView<UserSignUpController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _emailFormField(controller),
            SizedBox(height: S.y(30)),
            Obx(() => _passwordFormField(controller)),
            SizedBox(height: S.y(20)),
            Obx(() => _confirmPasswordFormField(controller)),
            SizedBox(height: S.y(30)),
            DefaultButton(
              text: L.signUp.btn,
              press: () => controller.submit(),
            ),
          ],
        ),
      ),
    );
  }
  TextFormField _confirmPasswordFormField(UserSignUpController controller) => TextFormField(
    obscureText: controller.hideConfirmPassword.value,
    onSaved: (newValue) => controller.confirmPassword.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signUp.confirmPassword.valid.empty;
      } else if (!RegexUtil.password.hasMatch(value)) {
        return L.signUp.confirmPassword.valid.format;
      }else if(controller.password.value.isNotEmpty && value != controller.password.value){
        return L.signUp.confirmPassword.valid.notEqual;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signUp.confirmPassword.labelText,
      hintText: L.signUp.confirmPassword.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.vpn_key),
      suffixIcon: IconButton(
        icon: Icon(controller.hideConfirmPassword.value ? Icons.remove_red_eye: Icons.remove_red_eye_outlined),
        onPressed: () => controller.hideConfirmPassword.value = !controller.hideConfirmPassword.value,
      ),
    ),
  );

  TextFormField _passwordFormField(UserSignUpController controller) => TextFormField(
    obscureText: controller.hidePassword.value,
    onChanged: (newValue) => controller.password.value = newValue,
    onSaved: (newValue) => controller.password.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signUp.password.valid.empty;
      } else if (!RegexUtil.password.hasMatch(value)) {
        return L.signUp.password.valid.format;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signUp.password.labelText,
      hintText: L.signUp.password.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.vpn_key),
      suffixIcon: IconButton(
        icon: Icon(controller.hidePassword.value ? Icons.remove_red_eye: Icons.remove_red_eye_outlined),
        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
      ),
    ),
  );
  TextFormField _emailFormField(UserSignUpController controller) => TextFormField(
    keyboardType: TextInputType.emailAddress,
    onSaved: (newValue) => controller.email.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signUp.email.valid.empty;
      } else if (!RegexUtil.email.hasMatch(value)) {
        return L.signUp.email.valid.format;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signUp.email.labelText,
      hintText: L.signUp.email.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.email),
    ),
  );
}