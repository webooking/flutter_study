---
typora-root-url: ./assets
---

# 1 GetX

https://pub.dev/packages/get



# 2 CounterScreen

## 2.1 hello world

<img src="/image-20201224115723784.png" alt="image-20201224115723784" style="zoom:20%;border: 5px solid #555;" />

### 2.1.1 程序入口

`main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_study/screen/counter_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: CounterScreen()));
}
```

### 2.1.2 CounterScreen

`flutter_study/screen/counter_screen.dart`

```dart
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Click ?'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('click-----------'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### 2.1.3 widget testing

- 加载CounterScreen
- 通过文本`Click ?`查找widget`AppBar`
- 触发`floatingActionButton`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_study/screen/counter_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('appBar text', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

    expect(find.textContaining('Click'), findsOneWidget);
    expect(find.textContaining('Click '), findsOneWidget);
    expect(find.text('Click ?'), findsOneWidget);
  });

  testWidgets('tap floatingActionButton', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

    expect(find.byTooltip('Increment'), findsOneWidget);
    final button = tester.widget<FloatingActionButton>(find.byType(FloatingActionButton));
    button.onPressed();
  });

  testWidgets('long press', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

    expect(find.text('Increment'), findsNothing);

    await tester.longPressAt(_rightEdgeOfFab(tester));
    await tester.pumpAndSettle();
    expect(find.text('Increment'), findsOneWidget);
  });
}
Offset _rightEdgeOfFab(WidgetTester tester) {
  final fab = find.byType(FloatingActionButton);
  return tester.getRect(fab).centerRight - const Offset(1.0, 0.0);
}
```



### 2.1.4 Reference API

| Api                                        | Desc               |
| ------------------------------------------ | ------------------ |
| await tester.longPressAt(Offset location); | 鼠标长按某个区域   |
| await tester.pumpAndSettle();              | 等待widget渲染结束 |

## 2.2 使用GetX重构

<img src="/image-20201224140956841.png" alt="image-20201224140956841" style="zoom:20%;border: 5px solid #555;" />

### 2.2.1 CounterController

```dart
import 'package:get/get.dart';

class CounterController extends GetxController{
  var count = 0.obs;
  void increment() => count.value++;
}
```

### 2.2.2 CounterScreen

```dart
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
```

### 2.2.3 widget testing

```
testWidgets('tap & observable count.value', (tester) async {
  await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

  expect(find.text('Clicks: 0'), findsOneWidget);

  final fab = find.byType(FloatingActionButton);
  await tester.tap(fab);
  await tester.pumpAndSettle();
  expect(find.text('Clicks: 1'), findsOneWidget);
});
```

## 2.3 多个widget之间数据共享

### 2.3.1 CounterScreen

```dart
import 'package:flutter/material.dart';
import 'package:flutter_study/controller/CounterController.dart';
import 'package:flutter_study/screen/counter/child_screen.dart';
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
            RaisedButton(
              child: Text('Go to Child Screen'),
              onPressed: () => Get.to<CounterController>(ChildScreen()),
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
```

### 2.3.2 ChildScreen

```dart
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
```

### 2.3.3 widget testing



