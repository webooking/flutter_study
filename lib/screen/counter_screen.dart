import 'package:flutter/material.dart';
import 'package:flutter_study/controller/CounterController.dart';
import 'package:get/get.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CounterController());

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
                  style: Theme.of(context).textTheme.headline4,
                )),
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
