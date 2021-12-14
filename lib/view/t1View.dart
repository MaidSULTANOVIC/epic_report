import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epic_report/controllers/report.controller.dart';

class T1View extends StatefulWidget {
  @override
  _T1ViewState createState() => _T1ViewState();
}

class _T1ViewState extends State<T1View> {
  ReportController controller = Get.put(ReportController());

  @override
  void initState() {
    super.initState();
  }

  int _value = 0;
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: Column(
      children: [
        Row(
          children: [
            Text("Speed of your first character :"),
            SizedBox(width: 3),
            Flexible(child: TextField()),
          ],
        ),
        Column(
          children: [
            Text("First character"),
            Row(
              children: [
                Text("Name :"),
                SizedBox(width: 3),
                Flexible(child: TextField()),
                SizedBox(width: 3),
                Text("Type :"),
                SizedBox(width: 3),
                Text("Dropdown"),
                SizedBox(width: 3),
              ],
            ),
            Row(
              children: [
                Text("Artefact :"),
                SizedBox(width: 3),
                Flexible(child: TextField()),
                SizedBox(width: 3),
                Text("HP :"),
                SizedBox(width: 3),
                Flexible(child: TextField()),
                SizedBox(width: 3),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: CheckboxListTile(
                        title: Text("Outspeed?"),
                        value: checkedValue,
                        onChanged: (value) {
                          setState(() {
                            checkedValue = value!;
                          });
                        })),
                SizedBox(width: 3),
                Text("HP :"),
                SizedBox(width: 3),
                Flexible(child: TextField()),
                SizedBox(width: 3),
              ],
            ),
            Row(
              children: [],
            ),
          ],
        )
      ],
    )));
  }
}
