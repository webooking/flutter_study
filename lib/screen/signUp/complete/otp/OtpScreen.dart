import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/screen/signUp/complete/otp/OtpForm.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  final String phone;

  const OtpScreen({
    Key key,
    @required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L.signUp.appBar),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(L.signUp.otp.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Text(L.signUp.otp.hint(phone)),
            _timer(),
            GestureDetector(
              onTap: () {
                Get.snackbar<void>(L.signUp.otp.title, L.signUp.otp.resent, snackPosition: SnackPosition.BOTTOM);
              },
              child: Text(
                L.signUp.otp.resent,
                style: TextStyle(
                  fontSize: 18,
                  color: kPrimaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: S.y(50)),
            OtpForm(),
          ],
        ),
      ),
    );
  }

  Row _timer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(L.signUp.otp.expired.prefix),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 30, end: 0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) => Text(
            '${value.toInt()}',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        Text(L.signUp.otp.expired.suffix),
      ],
    );
  }
}
