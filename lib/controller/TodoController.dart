import 'package:flutter/material.dart';
import 'package:flutter_study/model/TaskItem.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoController extends GetxController with SingleGetTickerProviderMixin {
  final formKey = GlobalKey<FormState>();

  TabController tabController;
  CalendarController calendarController;
  TextEditingController dateTextController;
  TextEditingController topicTextController;


  List<TaskItem> tasks = [
    TaskItem(topic: 'Yoga', date: '2021-01-19'),
    TaskItem(topic: 'Kickoff meeting', date: '2021-01-20'),
    TaskItem(topic: 'Flight', date: '2021-02-01'),
    TaskItem(topic: 'Homework', date: '2021-02-03'),
    TaskItem(topic: 'Dentist appointment', date: '2021-03-01'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    calendarController = CalendarController();
    dateTextController = TextEditingController();
    topicTextController = TextEditingController();
  }

  @override
  void onClose() {
    calendarController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
