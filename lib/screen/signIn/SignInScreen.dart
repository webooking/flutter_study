
import 'package:flutter/material.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/screen/signIn/SignInForm.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L.signIn.greet.appBar),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(L.signIn.greet.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Text(L.signIn.greet.subtitle),
            SizedBox(height: S.y(50)),
            SignInForm(),
          ],
        ),
      ),
    );
  }

}
