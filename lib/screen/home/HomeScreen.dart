import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('welcome to hooray'),
            Spacer(
              flex: 2,
            ),
            FutureBuilder(
                future: city(),
                builder: (context, snapshot){
                  dynamic cityName = snapshot.data;
                  return Text(cityName == null ? '' : cityName as String);
                }
            ),
            Spacer(
              flex: 2,
            ),
            DefaultButton(
              text: 'clear storage',
              press: () => GetStorage().erase(),
            ),
            Spacer(),
            DefaultButton(
              text: 'close app',
              press: () => exit(0),
            ),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
