import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/HomeController.dart';
import 'package:flutter_study/screen/home/components/CustomAppBar.dart';
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// 1. greet
                /// 2. searchField
                /// 3. categories
                /// 4. recommended
                /// 5. bottomNavigatorBar
              ],
            ),
          ),
        ),
      ),
    );
  }
}
