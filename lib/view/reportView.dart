import 'dart:collection';
import 'package:epic_report/view/t1View.dart';
import 'package:epic_report/view/t2View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epic_report/controllers/report.controller.dart';
import 'package:share_plus/share_plus.dart';

class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  ReportController controller = Get.put(ReportController());

  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  List<Widget> _children = [
    T1View(),
    T2View(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomAppBar(
          child: Container(
        height: 110,
        child: Column(
          children: [
            BottomNavigationBar(
              elevation: 0.5,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.ac_unit), label: "Turn 1"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.ac_unit), label: "Turn 2")
              ],
              iconSize: 0.0,
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
            ),
            TextButton(
              child: Text("Share"),
              onPressed: () {
                Share.share('Your report has been generated !');
              },
            )
          ],
        ),
      )),
    );
  }
}
