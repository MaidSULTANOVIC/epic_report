import 'dart:collection';
import 'package:epic_report/controllers/t2.controller.dart';
import 'package:epic_report/utils/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epic_report/controllers/t1.controller.dart';
import 'package:flutter/services.dart';

class T1View extends StatefulWidget {
  @override
  _T1ViewState createState() => _T1ViewState();
}

class _T1ViewState extends State<T1View> {
  T1Controller controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  String typeChangedValue = "Fire";
  String setChangedValue = "-";
  bool checkedValueImmunity = false;
  bool checkedValueOutspeed = false;

  List<String> _positionEnnemy = ['First', 'Second', 'Third'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(200, 50),
                  topRight: Radius.elliptical(200, 50)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Turn 1",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  Obx(() => Character(0)),
                  Obx(() => Character(1)),
                  Obx(() => Character(2)),
                  Obx(() => FirstCharacter(2)),
                ],
              ),
            )));
  }

  Container Character(int index) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Text(
              controller.name[index].text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Icon(
                      Icons.circle,
                      color: getColor(controller.typeChangedValue[index]),
                      size: 45.0,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(controller.artifact[index].text),
                          Text(controller.setChangedValue[index]),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          Text(controller.setSpeedString[index] + " SPD"),
                          Text(controller.setHealthPointString[index]),
                        ],
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(_positionEnnemy[index] + " enemy"),
                            content: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                          width: 200,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              controller.changeName(
                                                  value, index);
                                            },
                                            initialValue:
                                                controller.name[index].text,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                            ),
                                          )),
                                    ),
                                    SizedBox(width: 10),
                                    Text("Type :"),
                                    SizedBox(width: 5),
                                    DropdownButton<String>(
                                      value: controller.typeChangedValue[index],
                                      items: <String>[
                                        'Fire',
                                        'Ice',
                                        'Earth',
                                        'Light',
                                        'Dark'
                                      ].map((String valueType) {
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
                                          controller.typeChangedValue[index] =
                                              value!;
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
                                          child: TextFormField(
                                              onChanged: (value) {
                                                controller.changeArtifact(
                                                    value, index);
                                              },
                                              initialValue: controller
                                                  .artifact[index].text,
                                              decoration: InputDecoration(
                                                labelText: 'Artifact',
                                              ),
                                              keyboardType: TextInputType.name,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    20),
                                              ])),
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                        child: Container(
                                      //width: 80.0,
                                      child: TextField(
                                          controller: controller.hp[index],
                                          onChanged: (value) {
                                            controller.determineHP(
                                                index, index);
                                          },
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
                                              value: controller
                                                  .checkedValueOutspeed[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  controller
                                                          .checkedValueOutspeed[
                                                      index] = value!;
                                                });
                                              })),
                                    ),
                                    Flexible(
                                        child: Container(
                                      width: 50.0,
                                      child: TextField(
                                          controller: controller.cr[index],
                                          onChanged: (value) {
                                            controller.calculateSpeed(
                                                index, index);
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'CR%',
                                              hintText: '0-99'),
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
                                              value: controller
                                                  .checkedValueImmunity[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  controller
                                                          .checkedValueImmunity[
                                                      index] = value!;
                                                });
                                              })),
                                    ),
                                    Text("Other set :"),
                                    SizedBox(width: 5),
                                    Obx(() => DropdownButton<String>(
                                          value:
                                              controller.setChangedValue[index],
                                          items: <String>[
                                            '-',
                                            'Counter',
                                            'Lifesteal',
                                            'Injury'
                                          ].map((String valueSet) {
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
                                            controller.changeSet(value, index);
                                          },
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: TextField(
                                            controller:
                                                controller.comment[index],
                                            minLines: 1,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              labelText: 'Comment',
                                            ),
                                            keyboardType: TextInputType.text,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            inputFormatters: [
                                          LengthLimitingTextInputFormatter(60),
                                        ])),
                                  ],
                                )
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }

  Container FirstCharacter(int index) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Text(
              controller.name[index].text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Icon(
                      Icons.circle,
                      color: getColor(controller.typeChangedValue[index]),
                      size: 45.0,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(controller.artifact[index].text),
                          Text(controller.setChangedValue[index]),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          Text(controller.setSpeedString[index] + " SPD"),
                          Text(controller.setHealthPointString[index]),
                        ],
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(_positionEnnemy[index] + " enemy"),
                            content: Container(
                              height: 150.0,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Speed of your first character :",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(width: 5),
                                      Flexible(
                                          child: Container(
                                        color: Colors.white,
                                        width: 50.0,
                                        child: TextField(
                                            controller: controller.speedUser,
                                            onChanged: (value) {
                                              controller.calculateSpeed(0, 0);
                                              controller.calculateSpeed(1, 1);
                                              controller.calculateSpeed(2, 2);
                                            },
                                            decoration: InputDecoration(
                                              hintText: '200',
                                            ),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  3),
                                            ]),
                                      )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100.0,
                                        child: TextField(
                                            controller: controller.cr[index],
                                            onChanged: (value) {
                                              controller.calculateSpeed(
                                                  index, index);
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'CR% push',
                                                hintText: '0-99'),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ]),
                                      ),
                                      Container(
                                        width: 100.0,
                                        child: TextField(
                                            controller: controller.cr[index],
                                            onChanged: (value) {
                                              controller.calculateSpeed(
                                                  index, index);
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'CR% depush',
                                                hintText: '0-99'),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  2),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
