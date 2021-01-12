
import 'package:flutter/material.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/screen/signUp/SignUpForm.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L.signUp.appBar),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(L.signUp.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
            Text(L.signUp.subtitle),
            SizedBox(height: S.y(50)),
            SignUpForm(),
          ],
        ),
      ),
    );
  }

}
