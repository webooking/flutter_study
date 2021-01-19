import 'package:flutter/material.dart';
import 'package:flutter_study/config/size_config.dart';

Padding greet() => Padding(
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Hi Annie,',
        style: TextStyle(
          color: Colors.black,
          fontSize: 26,
        ),
      ),
      SizedBox(height: S.y(20),),
      Text(
        'Let’s Discover a New Adventure!',
        style: TextStyle(
          color: Color(0xFF979191),
          fontSize: 22,
        ),
      ),
    ],
  ),
);
