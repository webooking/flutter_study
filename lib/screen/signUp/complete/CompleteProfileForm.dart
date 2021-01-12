import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/RegexUtil.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/CompleteProfileController.dart';
import 'package:get/get.dart';

class CompleteProfileForm  extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompleteProfileController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _firstNameFormField(controller),
            SizedBox(height: S.y(30)),
            _lastNameFormField(controller),
            SizedBox(height: S.y(20)),
            _phoneFormField(controller),
            SizedBox(height: S.y(20)),
            _locationFormField(controller),
            SizedBox(height: S.y(30)),
            DefaultButton(
              text: L.signUp.completeProfile.btn,
              press: () => controller.submit(),
            ),
          ],
        ),
      ),
    );
  }
  TextFormField _locationFormField(CompleteProfileController controller) => TextFormField(
    onSaved: (newValue) => controller.location.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signUp.completeProfile.location.valid.empty;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signUp.completeProfile.location.labelText,
      hintText: L.signUp.completeProfile.location.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.location_on),
    ),
  );
  TextFormField _phoneFormField(CompleteProfileController controller) => TextFormField(
    onSaved: (newValue) => controller.phone.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signUp.completeProfile.phone.valid.empty;
      } else if (!RegexUtil.phone.hasMatch(value)) {
        return L.signUp.completeProfile.phone.valid.format;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signUp.completeProfile.phone.labelText,
      hintText: L.signUp.completeProfile.phone.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.phone),
    ),
  );
  TextFormField _lastNameFormField(CompleteProfileController controller) => TextFormField(
    onSaved: (newValue) => controller.lastName.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signUp.completeProfile.lastName.valid.empty;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signUp.completeProfile.lastName.labelText,
      hintText: L.signUp.completeProfile.lastName.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.person),
    ),
  );
  TextFormField _firstNameFormField(CompleteProfileController controller) => TextFormField(
    onSaved: (newValue) => controller.firstName.value = newValue,
    validator: (value) {
      if (value.isEmpty) {
        return L.signUp.completeProfile.firstName.valid.empty;
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: L.signUp.completeProfile.firstName.labelText,
      hintText: L.signUp.completeProfile.firstName.hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Icon(Icons.person),
    ),
  );
}