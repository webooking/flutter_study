import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/RegexUtil.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/OtpController.dart';
import 'package:get/get.dart';

class OtpForm extends GetView<OtpController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _otpForm(controller),
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

  Row _otpForm(OtpController controller) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ..._formFieldChildren(controller),
    ],
  );
  List<SizedBox> _formFieldChildren(OtpController controller) => List.generate(4, (index) =>
      SizedBox(
        width: S.x(60),
        child: TextFormField(
            autofocus: index == 0,
            focusNode: controller.focusNodes[index],
            obscureText: true,
            style: TextStyle(fontSize: 24),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: otpInputDecoration,
            onSaved: (newValue) => controller.otpCodes[index] = int.parse(newValue),
            validator: (value) {
              if (value.isEmpty) {
                return L.signUp.otp.valid.empty;
              } else if (!RegexUtil.otp.hasMatch(value)) {
                return L.signUp.otp.valid.format;
              }
              return null;
            },
            onChanged: (value){
              controller.otpCodes[index] = int.parse(value);
              controller.next(index);
            }
        ),
      )
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: S.x(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
