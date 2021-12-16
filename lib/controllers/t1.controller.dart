import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';

class T1Controller extends GetxController {
  RxList<String> _typeChangedValue = ['Fire', 'Fire', 'Fire'].obs;
  RxList<String> get typeChangedValue => this._typeChangedValue;

  RxList<String> _setChangedValue = ['-', '-', '-'].obs;
  RxList<String> get setChangedValue => this._setChangedValue;

  RxList<bool> _checkedValueImmunity = [false, false, false].obs;
  RxList<bool> get checkedValueImmunity => this._checkedValueImmunity;

  RxList<bool> _checkedValueOutspeed = [false, false, false].obs;
  RxList<bool> get checkedValueOutspeed => this._checkedValueOutspeed;

  TextEditingController _speedUser = TextEditingController();
  TextEditingController get speedUser => this._speedUser;

  List<TextEditingController> _name = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> get name => this._name;

  List<TextEditingController> _artifact = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
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

  @override
  void onInit() {
    super.onInit();
  }
}
