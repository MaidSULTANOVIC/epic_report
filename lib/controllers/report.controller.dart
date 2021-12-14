import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';

class ReportController extends GetxController {
  RxString _dropDownValue = "Vegetarian".obs;
  RxString get dropDownValue => this._dropDownValue;

  @override
  void onInit() {
    super.onInit();
  }
}
