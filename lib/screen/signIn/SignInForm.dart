import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/RegexUtil.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/UserSignInController.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserSignInController>();

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
            Text(
              L.signIn.hint.forgotPassword,
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: S.y(30)),
            DefaultButton(
              text: L.signIn.btn,
              press: () => controller.signIn(),
            ),
            SizedBox(height: S.y(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  L.signIn.hint.noAccount,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: S.x(20)),
                GestureDetector(
                  onTap: () {
                    Get.toNamed<void>('/signUp');
                  },
                  child: Text(
                    L.signIn.hint.signUp,
                    style: TextStyle(
                      fontSize: 18,
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _passwordFormField(UserSignInController controller) => TextFormField(
    obscureText: controller.hidePassword.value,
    onSaved: (newValue) => controller.password.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signIn.password.valid.empty;
      } else if (!RegexUtil.password.hasMatch(value)) {
        return L.signIn.password.valid.format;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signIn.password.labelText,
      hintText: L.signIn.password.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.vpn_key),
      suffixIcon: IconButton(
        icon: Icon(controller.hidePassword.value ? Icons.remove_red_eye: Icons.remove_red_eye_outlined),
        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
      ),
    ),
  );
  TextFormField _emailFormField(UserSignInController controller) => TextFormField(
    keyboardType: TextInputType.emailAddress,
    onSaved: (newValue) => controller.email.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signIn.email.valid.empty;
      } else if (!RegexUtil.email.hasMatch(value)) {
        return L.signIn.email.valid.format;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signIn.email.labelText,
      hintText: L.signIn.email.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.email),
    ),
  );
}