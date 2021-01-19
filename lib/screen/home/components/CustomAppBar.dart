import 'package:flutter/material.dart';
import 'package:flutter_study/config/constants.dart';
import 'package:flutter_study/controller/HomeController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

AppBar customAppBar(HomeController controller) => AppBar(
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.location_on, color: const Color(0xFF6367F1),),
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
);

Drawer leftDrawer() => Drawer(
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
);

Drawer rightDrawer() => Drawer(
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
);