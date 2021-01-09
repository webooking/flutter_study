import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:get_storage/get_storage.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign in with your email and password'),
            Spacer(flex: 2,),
            DefaultButton(
              text: 'Simulation signIn is successful',
              press: () => GetStorage().write(kAccessToken, 'a03c3b36-5259-11eb-ae93-0242ac130002'),
            ),
            Spacer(),
            DefaultButton(
              text: 'close app',
              press: () => exit(0),
            ),
            Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }
}
