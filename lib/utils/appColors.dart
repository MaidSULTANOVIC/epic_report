import 'package:flutter/widgets.dart';

class AppColors {
  static Color menuBackground = Color(0xFf0f0f0f);
  static Color text = Color(0xFfffffff);

  static Color element_Fire = Color(0xFFf7250c);
  static Color element_Ice = Color(0xFf1bb7fa);
  static Color element_Earth = Color(0xFf2de01d);
  static Color element_Light = Color(0xFfe8c115);
  static Color element_Dark = Color(0xFfa412de);
}

Color getColor(String type) {
  if (type == 'Fire') {
    return AppColors.element_Fire;
  } else if (type == 'Ice') {
    return AppColors.element_Ice;
  } else if (type == 'Earth') {
    return AppColors.element_Earth;
  } else if (type == 'Light') {
    return AppColors.element_Light;
  } else {
    return AppColors.element_Dark;
  }
}
