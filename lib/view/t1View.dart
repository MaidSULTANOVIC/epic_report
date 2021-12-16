import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epic_report/controllers/report.controller.dart';
import 'package:flutter/services.dart';

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

  String typeChangedValue = "Fire";
  String setChangedValue = "-";
  bool checkedValueImmunity = false;
  bool checkedValueOutspeed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Speed of your first character :"),
              SizedBox(width: 5),
              Flexible(
                  child: Container(
                width: 50.0,
                child: TextField(
                    decoration: InputDecoration(
                      hintText: '200',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                    ]),
              )),
            ],
          ),
          Character("First"),
          Character("Second"),
          Character("Third")
        ],
      ),
    )));
  }

  Container Character(String enemyNum) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Text(
            enemyNum + " enemy",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                    width: 200,
                    child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                        ])),
              ),
              SizedBox(width: 10),
              Text("Type :"),
              SizedBox(width: 5),
              DropdownButton<String>(
                value: typeChangedValue,
                items: <String>['Fire', 'Ice', 'Earth', 'Light', 'Dark']
                    .map((String valueType) {
                  return DropdownMenuItem<String>(
                    value: valueType,
                    child: Center(
                        child: Text(
                      valueType,
                      textAlign: TextAlign.center,
                    )),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    typeChangedValue = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                    width: 200,
                    child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Artifact',
                        ),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                        ])),
              ),
              SizedBox(width: 10),
              Flexible(
                  child: Container(
                //width: 80.0,
                child: TextField(
                    decoration: InputDecoration(
                      labelText: 'HP',
                      hintText: '10000',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                    ]),
              )),
              SizedBox(width: 3),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                    width: 160.0,
                    child: CheckboxListTile(
                        title: Text(
                          "Enemy outspeed",
                          textAlign: TextAlign.center,
                        ),
                        value: checkedValueOutspeed,
                        onChanged: (value) {
                          setState(() {
                            checkedValueOutspeed = value!;
                          });
                        })),
              ),
              Flexible(
                  child: Container(
                width: 50.0,
                child: TextField(
                    decoration:
                        InputDecoration(labelText: 'CR%', hintText: '0-99'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2),
                    ]),
              )),
              SizedBox(width: 10),
              Text(
                "(Speed is calculated\nautomatically)",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                    width: 160.0,
                    child: CheckboxListTile(
                        title: Text(
                          "Immunity",
                          textAlign: TextAlign.center,
                        ),
                        value: checkedValueImmunity,
                        onChanged: (value) {
                          setState(() {
                            checkedValueImmunity = value!;
                          });
                        })),
              ),
              Text("Other set :"),
              SizedBox(width: 5),
              DropdownButton<String>(
                value: setChangedValue,
                items: <String>['-', 'Counter', 'Lifesteal', 'Injury']
                    .map((String valueSet) {
                  return DropdownMenuItem<String>(
                    value: valueSet,
                    child: Center(
                        child: Text(
                      valueSet,
                      textAlign: TextAlign.center,
                    )),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    setChangedValue = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: TextField(
                      minLines: 1,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Comment',
                      ),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      inputFormatters: [
                    LengthLimitingTextInputFormatter(60),
                  ])),
            ],
          )
        ],
      ),
    );
  }
}
