import 'package:flutter/material.dart';
import 'package:flutter_study/controller/CounterController.dart';
import 'package:flutter_study/screen/counter/counter_screen.dart';
import 'package:get/get.dart';

class ChildScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CounterController>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('child screen get count value from parent: '),
            Obx(() => Text(
              '${controller.count.value}',
              key: ValueKey('ChildScreenText'),
              style: Theme.of(context).textTheme.headline4,
            )),
            RaisedButton(
              child: Text('Go to Parent Screen'),
              onPressed: () => Get.back<CounterController>(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.decrement(),
        tooltip: 'Decrement',
        child: Icon(Icons.remove),
      ),
    );
  }
}
