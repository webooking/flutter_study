import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_study/components/DefaultButton.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/controller/HomeController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            FutureBuilder(
                future: city(),
                builder: (context, snapshot){
                  dynamic cityName = snapshot.data;
                  return Text(cityName == null ? '' : cityName as String);
                }
            ),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset('assets/images/drawer.svg'),
              onPressed: controller.openDrawer,
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: controller.openEndDrawer,
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: Get.back,
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: Get.back,
              ),
            ],
          ),
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Right Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: Get.back,
            ),
            ListTile(
              title: Text('Item 4'),
              onTap: Get.back,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('welcome to hooray'),
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
