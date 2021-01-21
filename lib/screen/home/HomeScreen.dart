import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/HomeController.dart';
import 'package:flutter_study/screen/home/components/Categories.dart';
import 'package:flutter_study/screen/home/components/CustomAppBar.dart';
import 'package:flutter_study/screen/home/components/Greet.dart';
import 'package:flutter_study/screen/home/components/Recommend.dart';
import 'package:flutter_study/screen/home/components/SearchField.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: customAppBar(controller),
      drawer: leftDrawer(),
      endDrawer: rightDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: S.y(15),),
              /// 1. greet
              greet(),
              SizedBox(height: S.y(40),),
              /// 2. searchField
              searchField(),
              SizedBox(height: S.y(40),),
              /// 3. categories
              categories(),
              SizedBox(height: S.y(40),),
              /// 4. recommended
              ...recommend(),
              SizedBox(height: S.y(40),),
              ...recommend(),
              /// 5. bottomNavigatorBar
            ],
          ),
        ),
      ),
    );
  }
}
