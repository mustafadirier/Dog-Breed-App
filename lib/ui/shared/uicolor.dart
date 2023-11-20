import 'package:flutter/material.dart';

class UIColor {
  //main color
  static Color transparent = Colors.transparent;
  static Color black = const Color(0xFF000000);
  static Color white = const Color(0xFFFFFFFF); //background color
  static Color primaryColor = const Color(0xFF0055D3);
  static Color buttonColor = const Color(0xFF0085FF);
  static Color secondartColor = const Color(0xFF3C3C43);
  static Color systemGray3 = const Color(0xFFC7C7CC);
  static Color systemGray4 = const Color(0xFFD1D1D6);
  static Color systemGray5 = const Color(0xFFE5E5EA);
  static Color systemGray6 = const Color(0xFFF2F2F7);
}

class UIGradient {
  static LinearGradient cardGradient = LinearGradient(
      colors: [UIColor.black.withOpacity(.64), UIColor.transparent],
      begin: Alignment.bottomCenter,
      end: Alignment.center);
}
