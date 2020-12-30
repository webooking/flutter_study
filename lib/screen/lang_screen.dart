import 'package:flutter/material.dart';
import 'package:flutter_study/config/lang.dart';
import 'package:flutter_study/controller/LangController.dart';
import 'package:get/get.dart';

class LangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LangController>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton.icon(
              icon: Icon(Icons.date_range),
              label: Text(L.date.picker),
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  locale: controller.lang.toLocale(),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                );
              },
            ),
            SizedBox(height: 20),
            Text(L.hello),
            SizedBox(height: 20),
            Text(L.greet('yuri')),
            SizedBox(height: 100),
            DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down),
              value: controller.lang,
              items: L.locales.entries.map((entry) => DropdownMenuItem<String>(value: entry.key, child: Text(entry.value))).toList(),
              onChanged: (String value) {
                controller.changeLocale(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
