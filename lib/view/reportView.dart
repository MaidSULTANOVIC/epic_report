import 'dart:collection';
import 'package:epic_report/controllers/t2.controller.dart';
import 'package:epic_report/utils/appColors.dart';
import 'package:epic_report/view/t1View.dart';
import 'package:epic_report/view/t2View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epic_report/controllers/t1.controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  T1Controller controller = Get.put(T1Controller());
  T2Controller controller2 = Get.put(T2Controller());

  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  List<Widget> _children = [
    T1View(),
    T2View(),
  ];

  String calculateSpeed(int index) {
    String finalResult = "";
    int result = int.parse(controller.speedUser.text);
    try {
      result =
          (result.toDouble() * (double.parse(controller.cr[index].text) / 100))
              .toInt();
    } catch (e) {
      print(controller.cr[index].text);
    }

    controller.checkedValueOutspeed[index]
        ? result += int.parse(controller.speedUser.text)
        : null;

    if (result % 5 == 1) {
      result -= 1;
      finalResult += result.toString();
    } else if (result % 5 == 4) {
      result += 1;
      finalResult += result.toString();
    } else if (result % 5 != 0) {
      result -= result % 5;

      finalResult = result.toString();

      result += 5;

      finalResult += "-" + result.toString();
    } else {
      finalResult = result.toString();
    }

    return finalResult;
  }

  void processData() {
    String data = "";

    String firstTurn = "```────────── T1 ──────────```\n";
    for (int i = 0; i < 3; i++) {
      switch (controller.typeChangedValue[i]) {
        case "Fire":
          firstTurn += ":red";
          break;
        case "Ice":
          firstTurn += ":blue";
          break;
        case "Earth":
          firstTurn += ":green";
          break;
        case "Light":
          firstTurn += ":yellow";
          break;
        case "Dark":
          firstTurn += ":purple";
          break;

        default:
          break;
      }
      firstTurn += "_circle: __**" + controller.name[i].text;
      firstTurn += " :**__ (**~" + calculateSpeed(i) + "** SPD)\n";
      var formatter = NumberFormat('###,000');
      print(formatter.format(16987).replaceAll(',', ' '));
      //firstTurn += "> **"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("TOUR 1 ", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomAppBar(
          child: Container(
        color: Colors.white,
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
                processData();
                // Share.share('Your report has been generated !');
              },
            )
          ],
        ),
      )),
    );
  }
}
