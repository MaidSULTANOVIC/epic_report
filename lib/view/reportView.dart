import 'dart:collection';
//import 'dart:html';
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
  String share_data = "";
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

  String calculateSpeed(int index, int cNum) {
    String finalResult = "";
    int result = 0;

    if (cNum == 0) {
      if (controller.speedUser.text.isEmpty) {
        finalResult = "?";
      } else {
        result = int.parse(controller.speedUser.text);
        try {
          result = (result.toDouble() *
                  (double.parse(controller.cr[index].text) / 100))
              .toInt();
        } catch (e) {
          print(controller.cr[index].text);
        }

        controller.checkedValueOutspeed[index]
            ? result += int.parse(controller.speedUser.text)
            : null;
      }
    } else {
      if (controller2.speedUser.text.isEmpty) {
        finalResult = "?";
      } else {
        result = int.parse(controller2.speedUser.text);
        try {
          result = (result.toDouble() *
                  (double.parse(controller2.cr[index].text) / 100))
              .toInt();
        } catch (e) {
          print(controller2.cr[index].text);
        }

        controller2.checkedValueOutspeed[index]
            ? result += int.parse(controller2.speedUser.text)
            : null;
      }
    }
    finalResult += "~";

    if (result % 5 == 1) {
      result -= 1;
      finalResult += result.toString();
    } else if (result % 5 == 4) {
      result += 1;
      finalResult += result.toString();
    } else if (result % 5 != 0) {
      result -= result % 5;

      finalResult += result.toString();

      result += 5;

      finalResult += "-" + result.toString();
    } else {
      finalResult += result.toString();
    }

    return finalResult;
  }

  String determineType(int index, int cNum) {
    String data = "";
    if (cNum == 0) {
      switch (controller.typeChangedValue[index]) {
        case "Fire":
          data += ":red";
          break;
        case "Ice":
          data += ":blue";
          break;
        case "Earth":
          data += ":green";
          break;
        case "Light":
          data += ":yellow";
          break;
        case "Dark":
          data += ":purple";
          break;

        default:
          data += ":white";
          break;
      }
      data += "_circle: __**" +
          (controller.name[index].text.isNotEmpty
              ? controller.name[index].text
              : "?");
    } else {
      switch (controller2.typeChangedValue[index]) {
        case "Fire":
          data += ":red";
          break;
        case "Ice":
          data += ":blue";
          break;
        case "Earth":
          data += ":green";
          break;
        case "Light":
          data += ":yellow";
          break;
        case "Dark":
          data += ":purple";
          break;

        default:
          data += ":white";
          break;
      }
      data += "_circle: __**" +
          (controller2.name[index].text.isNotEmpty
              ? controller2.name[index].text
              : "?");
    }

    return data;
  }

  String determineSets(int index, int cNum) {
    String data = "";
    List<String> sets = [];

    if (cNum == 0 &&
        (controller.checkedValueImmunity[index] ||
            controller.setChangedValue[index] != "-")) {
      data += "> ";
      if (controller.checkedValueImmunity[index]) {
        sets.add(":muscle:");
      }
      switch (controller.setChangedValue[index]) {
        case "Counter":
          sets.add(":punch:");
          break;
        case "Lifesteal":
          sets.add(":drop_of_blood:");
          break;
        case "Injury":
          sets.add(":broken_heart:");
          break;

        default:
          break;
      }
    } else if (cNum == 1 &&
        (controller2.checkedValueImmunity[index] ||
            controller2.setChangedValue[index] != "-")) {
      data += "> ";
      if (controller2.checkedValueImmunity[index]) {
        sets.add(":muscle:");
      }
      switch (controller2.setChangedValue[index]) {
        case "Counter":
          sets.add(":punch:");
          break;
        case "Lifesteal":
          sets.add(":drop_of_blood:");
          break;
        case "Injury":
          sets.add(":broken_heart:");
          break;

        default:
          break;
      }
    }

    if (sets.isNotEmpty) {
      for (int k = 0; k < sets.length; k++) {
        data += sets[k];
        if (k < (sets.length - 1)) {
          data += " / ";
        }
      }
      data += "\n";
    }

    return data;
  }

  String determineComment(int index, int cNum) {
    String data = "";

    if (cNum == 0 && controller.comment[index].text.isNotEmpty) {
      data += "> *" + controller.comment[index].text + "*\n";
    } else if (cNum == 1 && controller2.comment[index].text.isNotEmpty) {
      data += "> *" + controller2.comment[index].text + "*\n";
    }

    return data;
  }

  String determineHP(int index, int cNum) {
    var formatter = NumberFormat('###,000');
    String data = "> **";
    int enemyHP = 0;

    if (cNum == 0 && controller.hp[index].text.isNotEmpty) {
      enemyHP = int.parse(controller.hp[index].text);

      data +=
          (formatter.format((enemyHP ~/ 100) * 100 + 100).replaceAll(',', ' '))
              .toString();
    } else if (cNum == 1 && controller2.hp[index].text.isNotEmpty) {
      enemyHP = int.parse(controller2.hp[index].text);

      data +=
          (formatter.format((enemyHP ~/ 100) * 100 + 100).replaceAll(',', ' '))
              .toString();
    } else {
      data += "?";
    }
    data += "** HP\n";

    return data;
  }

  void processData() {
    String data = "";

    for (int j = 0; j < 2; j++) {
      data += "```────────── T" + (j + 1).toString() + " ──────────```\n";

      for (int i = 0; i < 3; i++) {
        data += determineType(i, j);
        data += " :**__ (**" + calculateSpeed(i, j) + "** SPD)\n";
        data += determineHP(i, j);
        data += determineSets(i, j);

        String enemyArtifact = (j == 0
            ? controller.artifact[i].text
            : controller2.artifact[i].text);
        if (enemyArtifact.isEmpty) {
          enemyArtifact = "?";
        }
        data += "> `" + enemyArtifact.toString() + "`\n";

        data += determineComment(i, j);

        if (i < 2) {
          data += "\n";
        }
      }
    }

    share_data = data;
  }

  final pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: PageView(
        controller: pageViewController,
        children: _children,
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        height: 54,
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: Colors.black))),
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: Text(
            "Share",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            processData();
            Share.share(share_data);
          },
        ),
      )),
    );
  }
}
