import 'dart:ui';
import 'package:flutter/material.dart';

class TaskItem {
  Key key;
  String topic;
  String date;

  TaskItem({
    this.topic,
    this.date,
  }) {
    key = UniqueKey();
  }
}
