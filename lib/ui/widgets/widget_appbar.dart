import 'package:dog_breed_app/ui/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import '../shared/uicolor.dart';

AppBar appBar() {
  return AppBar(
    leadingWidth: 0,
    elevation: 0.0,
    backgroundColor: UIColor.white,
    bottomOpacity: 0.0,
    shadowColor: UIColor.white,
    title: Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 16),
      child: Center(
          child: TextBasic(
        text: "Dog Breed App!",
        color: UIColor.black,
        letterSpacing: .01,
        lineHeight: 0.26,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      )),
    ),
  );
}
