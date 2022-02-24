import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class T1Controller extends GetxController {
  RxList<String> _typeChangedValue = ['Fire', 'Fire', 'Fire'].obs;
  RxList<String> get typeChangedValue => this._typeChangedValue;

  RxList<String> _setChangedValue = <String>['-', '-', '-'].obs;
  List<String> get setChangedValue => this._setChangedValue;

  RxList<bool> _checkedValueImmunity = [false, false, false].obs;
  RxList<bool> get checkedValueImmunity => this._checkedValueImmunity;

  RxList<bool> _checkedValueOutspeed = [false, false, false].obs;
  RxList<bool> get checkedValueOutspeed => this._checkedValueOutspeed;

  TextEditingController _speedUser = TextEditingController();
  TextEditingController get speedUser => this._speedUser;

  RxList<TextEditingController> _name = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ].obs;
  List<TextEditingController> get name => this._name;

  RxList<TextEditingController> _artifact = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ].obs;
  List<TextEditingController> get artifact => this._artifact;

  List<TextEditingController> _hp = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> get hp => this._hp;

  List<TextEditingController> _cr = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> get cr => this._cr;

  List<TextEditingController> _comment = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> get comment => this._comment;

  void changeName(name, index) {
    this._name[index].text = name;
    this._name.refresh();
  }

  String determineHP(int index, int cNum) {
    var formatter = NumberFormat('###,000');
    String data = "";
    int enemyHP = 0;

    if (cNum == 0 && this.hp[index].text.isNotEmpty) {
      enemyHP = int.parse(this.hp[index].text);

      data +=
          (formatter.format((enemyHP ~/ 100) * 100 + 100).replaceAll(',', ' '))
              .toString();
    } else if (cNum == 1 && this.hp[index].text.isNotEmpty) {
      enemyHP = int.parse(this.hp[index].text);

      data +=
          (formatter.format((enemyHP ~/ 100) * 100 + 100).replaceAll(',', ' '))
              .toString();
    } else {
      data += "?";
    }
    data += " HP\n";

    return data;
  }

  String calculateSpeed(int index, int cNum) {
    String finalResult = "";
    int result = 0;

    if (cNum == 0) {
      if (this.speedUser.text.isEmpty) {
        finalResult = "?";
      } else {
        result = int.parse(this.speedUser.text);
        try {
          result =
              (result.toDouble() * (double.parse(this.cr[index].text) / 100))
                  .toInt();
        } catch (e) {
          print(this.cr[index].text);
        }

        this.checkedValueOutspeed[index]
            ? result += int.parse(this.speedUser.text)
            : null;
      }
    } else {
      if (this.speedUser.text.isEmpty) {
        finalResult = "?";
      } else {
        result = int.parse(this.speedUser.text);
        try {
          result =
              (result.toDouble() * (double.parse(this.cr[index].text) / 100))
                  .toInt();
        } catch (e) {
          print(this.cr[index].text);
        }

        this.checkedValueOutspeed[index]
            ? result += int.parse(this.speedUser.text)
            : null;
      }
    }
    finalResult += "";

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

  void changeArtifact(name, index) {
    this._artifact[index].text = name;
    this._artifact.refresh();
  }

  void changeSet(name, index) {
    this._setChangedValue[index] = name;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
