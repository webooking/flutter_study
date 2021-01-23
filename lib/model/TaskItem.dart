import 'dart:ui';
import 'package:flutter/material.dart';

class TaskItem {
  Key key;
  final String topic;
  final String date;

  TaskItem({
    @required this.topic,
    @required this.date,
  }) {
    key = UniqueKey();
  }
}
