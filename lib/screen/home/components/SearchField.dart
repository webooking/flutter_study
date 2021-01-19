import 'package:flutter/material.dart';

Padding searchField() => Padding(
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Search Hotels, Taxi etc..',
      prefixIcon: Icon(Icons.search),
      filled: true,
      fillColor: Color(0xFFF4F6FE),
    ),
  ),
);