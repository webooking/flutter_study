---
typora-root-url: ./assets
---

# 1 custom tab bar

<img src="/image-20210121031133064.png" alt="image-20210121031133064" style="zoom:50%;" />

相关的flutter组件：

- TabBar
- TabBarView
- TabController
- SingleGetTickerProviderMixin

## 1.1 TodoController

```
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
```

## 1.2 TodoScreen

```
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
```

## 1.3 refactoring

### 1.3.1 TodoScreen

```
customTabBar(
  controller: controller.tabController,
  title: ['Monthly','Daily'],
  body: [
    Text('Monthly body',),
    Text('Daily body',),
  ]
)
```

### 1.3.2 CustomTabBar

```
import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';

List<Widget> customTabBar({TabController controller, List<String> title, List<Widget> body}) => [
      Container(
        width: S.x(285),
        height: S.y(50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Color(0xFFC8CDDA)),
        ),
        child: TabBar(
          controller: controller,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xFF5A95FF),
          ),
          tabs: title.map((e) => Tab(text: e)).toList(),
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: controller,
          children: body.asMap().map((index, value) => MapEntry(index,
                  Container(
                    height: S.y(1000),
                    color: index == 0 ? Colors.green : Colors.orangeAccent,
                    child: value,
                  )))
              .values
              .toList(),
        ),
      ),
    ];

```

# 2 Calendar

## 2.1 TodoController

```
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  CalendarController calendarController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    calendarController = CalendarController();
  }

  @override
  void onClose() {
    calendarController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
```

## 2.2 TodoScreen

```
TableCalendar(
  calendarController: controller.calendarController,
  locale: window.locale.toString(),
)
```



# 3 simple ListView

```
Container(
  margin: EdgeInsets.symmetric(vertical: 20.0),
  width: double.infinity,
  height: S.y(600),
  color: Color(0xEFEFF5F8),
  child: Column(
    children: [
      Text(
        'This month',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
      ListTile(
        leading: SvgPicture.asset('assets/icons/complete.svg',
          height: 20,
          width: 20,
          color: Colors.lightGreen,
        ),
        title: Text(
          'Yoga',
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  ),
)
```



# 4 FloatingActionButton

```
FloatingActionButton(
  onPressed: (){},
  tooltip: 'Increment',
  child: Icon(Icons.add),
)
```



# 5 Dialog

Modal view

```
Get.dialog<void>(
  AlertDialog(
    title: Text('This should not be closed automatically'),
    content: Text('This should not be closed automatically'),
    actions: <Widget>[
      TextButton(
        child: Text('Close'),
        onPressed: () {
          Get.back<void>();
        },
      )
    ],
  ),
  barrierDismissible: false,
),
```

# 6 Task ListView

```
Obx(() {
  if (controller.tasks.isEmpty) {
    return Text('Nothing to do');
  }
  final random = Random();
  return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: controller.tasks.length,
      itemBuilder: (context, index) {
        final item = controller.tasks[index];

        return Dismissible(
          // Each Dismissible must contain a Key
          key: item.key,
          onDismissed: (direction) {
            // Remove the item from the data source.
            controller.tasks.removeAt(index);
            Get.snackbar<void>('Delete', 
              '${item.topic} dismissed', 
              snackPosition: SnackPosition.BOTTOM);
           },
           // Show a red background as the item is swiped away.
           background: Container(color: Colors.red),
           child: InkWell(
             splashColor: Colors.white.withOpacity(0.1),
             highlightColor: Colors.transparent,
             borderRadius: BorderRadius.circular(8),
             onTap: () => Get.dialog<void>(
               AlertDialog(
                 title: Text('This should not be closed automatically'),
                 content: Text('This should not be closed automatically'),
                 actions: <Widget>[
                   TextButton(
                     child: Text('Delete'),
                     onPressed: () {
                       controller.tasks.removeAt(index);
                       Get.back<void>();
                     },
                   ),
                   TextButton(
                     child: Text('Close'),
                     onPressed: () {
                       Get.back<void>();
                     },
                   )
                 ],
               ),
               barrierDismissible: false,
             ),
       child: ListTile(
         leading: SvgPicture.asset(
           'assets/icons/complete.svg',
           height: 20,
           width: 20,
           color: random.nextBool() ? Colors.lightGreen : Colors.grey[300],
         ),
         title: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               '${item.topic}',
               style: TextStyle(
                 fontSize: 16.0, 
                 color: Colors.black, 
                 fontWeight: FontWeight.bold),
             ),
             Text('${item.date}'),
            ],
          ),
       ),
     )
   );
 });
}),
```



