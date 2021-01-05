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
            DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down),
              value: controller.lang,
              items: L.locales.entries.map((entry) => DropdownMenuItem<String>(value: entry.key, child: Text(entry.value))).toList(),
              onChanged: (String value) {
                controller.changeLocale(value);
              },
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('date.picker'),
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
              ],
            ),
            SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('hello', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(L.hello),
                ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('greet(firstName)', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(L.greet('yuri')),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('notice', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(L.notice),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('item.zero', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(L.product.online.item(0)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('item.one', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(L.product.online.item(1)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('item.more', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(L.product.online.item(100)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('contact(Gender.Male, lastName)', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(L.user.contact(Gender.Male, 'Li', 'yuri')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('contact(Gender.Female, lastName)', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(L.user.contact(Gender.Female, 'Marks', null)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
