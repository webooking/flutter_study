import 'package:flutter/material.dart';
import 'package:flutter_study/config/routes.dart';
import 'package:flutter_study/controller/CounterController.dart';
import 'package:get/get.dart';

class CounterScreen extends GetView<CounterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Clicks: ${controller.count}')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            Obx(() => Text(
                  '${controller.count}',
                  key: ValueKey('ParentScreenText'),
                  style: Theme.of(context).textTheme.headline4,
                )),
            RaisedButton(
              child: Text('Go to Child Screen'),
              onPressed: () => Get.toNamed<void>(RouteNames.CounterChildScreen),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
