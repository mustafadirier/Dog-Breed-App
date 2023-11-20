import 'package:dog_breed_app/ui/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import '../shared/uicolor.dart';
import '../shared/uifont.dart';

//Basic button
class ButtonBasic extends StatelessWidget {
  final String? buttonText;
  final Color? bgColor;
  final Color? textColor;
  final Gradient? bgGradient;
  final Function()? onTap;
  final int? flex;
  final double radius;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? padding;
  final Widget? prefixIcon;
  final double elevation;

  // ignore: use_key_in_widget_constructors
  const ButtonBasic(
      {this.buttonText,
      this.bgColor,
      this.textColor,
      this.bgGradient,
      this.onTap,
      this.flex,
      this.radius = 8,
      this.height,
      this.fontSize,
      this.width,
      this.padding,
      this.prefixIcon,
      this.elevation = 0});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width ?? 100,
          height: height ?? 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            gradient: bgGradient,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (prefixIcon != null) prefixIcon!,
              Flexible(
                child: TextBasic(
                  text: buttonText ?? "",
                  color: textColor ?? UIColor.white,
                  fontSize: fontSize ?? 16,
                  fontFamily: UIFont.galano,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
