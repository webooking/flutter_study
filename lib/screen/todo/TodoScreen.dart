import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/TodoController.dart';
import 'package:get/get.dart';

class TodoScreen extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: S.x(285),
                height: S.y(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Color(0xFFC8CDDA)),
                ),
                child: TabBar(
                  controller: controller.tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFF5A95FF),
                  ),
                  tabs: [
                    Tab(text: 'Monthly',),
                    Tab(text: 'Daily',),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                    children: [
                      Container(
                        height: S.y(1000),
                        color: Colors.green,
                        child: Text('Monthly body',),
                      ),
                      Container(
                        height: S.y(1000),
                        color: Colors.orangeAccent,
                        child: Text('Daily body',),
                      ),
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
