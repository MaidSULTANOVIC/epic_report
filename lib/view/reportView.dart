import 'dart:collection';
import 'package:epic_report/view/t1View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epic_report/controllers/report.controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: T1View());
  }
}
