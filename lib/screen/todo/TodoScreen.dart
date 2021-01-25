import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';
import 'package:flutter_study/controller/TodoController.dart';
import 'package:flutter_study/model/TaskItem.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_study/util/DateTimeUtil.dart';

class TodoScreen extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog<void>(
          _createTaskDialog(context),
          barrierDismissible: false,
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: _customTab(head: [
              'Monthly',
              'Daily'
            ], body: [
              // Text('Monthly body'),
              _monthlyBody(),
              Text('Daily body'),
            ]),
          ),
        ),
      ),
    );
  }

  AlertDialog _createTaskDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Task'),
      content: Form(
        key: controller.formKey,
        child: Column(
          children: [
            _topicFormField(),
            SizedBox(height: S.y(30)),
            _dateFormField(context),
            SizedBox(height: S.y(30)),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Save'),
          onPressed: () {
            controller.formKey.currentState.save();
            controller.tasks.add(TaskItem(topic: controller.topicTextController.text, date: controller.dateTextController.text));
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
    );
  }

  Future _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      controller.dateTextController.text = picked.toLocalString();
    }
  }

  TextFormField _dateFormField(BuildContext context) => TextFormField(
        controller: controller.dateTextController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Date',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(Icons.date_range),
        ),
        onTap: () => _selectDate(context),
      );
  TextFormField _topicFormField() => TextFormField(
        controller: controller.topicTextController,
        decoration: InputDecoration(
          labelText: 'Topic',
          hintText: 'Enter task topic',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(Icons.topic),
        ),
      );

  List<Widget> _customTab({List<String> head, List<Widget> body}) => [
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
            tabs: head.map((e) => Tab(text: e)).toList(),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: TabBarView(
            controller: controller.tabController,
            children: body,
          ),
        ),
      ];
  Widget _monthlyBody() => Column(
        children: [
          TableCalendar(
            calendarController: controller.calendarController,
            locale: window.locale.toString(),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
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
                                  Get.snackbar<void>('Delete', '${item.topic} dismissed', snackPosition: SnackPosition.BOTTOM);
                                },
                                // Show a red background as the item is swiped away.
                                background: Container(color: Colors.red),
                                child: InkWell(
                                  splashColor: Colors.white.withOpacity(0.1),
                                  highlightColor: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () => Get.dialog<void>(
                                    _deleteTaskDialog(index),
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
                                          style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                        Text('${item.date}'),
                                      ],
                                    ),
                                  ),
                                ));
                          });
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  AlertDialog _deleteTaskDialog(int index) {
    return AlertDialog(
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
    );
  }
}
