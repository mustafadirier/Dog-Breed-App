import 'package:dog_breed_app/ui/shared/uicolor.dart';
import 'package:flutter/material.dart';
import '../shared/uifont.dart';

class BasicTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? requestFocus;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;
  final bool? enabled;
  final double? radius;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? onChanged;
  final Function()? onTap;
  final InputBorder? border;

  // ignore: use_key_in_widget_constructors
  const BasicTextField({
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.requestFocus,
    this.validator,
    this.controller,
    required this.obscureText,
    this.maxLength,
    this.maxLines,
    this.enabled,
    this.radius,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) =>event.device,
      enabled: enabled,
      onTap: onTap,
      cursorColor: UIColor.primaryColor,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: (v) {
        if (requestFocus != null) {
          FocusScope.of(context).requestFocus(requestFocus);
        }
      },
        controller: controller,
      obscureText: obscureText,
      maxLines: maxLines ?? 25,
      validator: validator,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      style: TextStyle(
 
                      color: UIColor.secondartColor.withOpacity(.60),
                      fontSize: 16,
                      fontFamily: UIFont.galano,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
      ),
      decoration: InputDecoration(

     
                      
     
        alignLabelWithHint: true,
        hintText: hint,
        hintStyle: TextStyle(
          color: UIColor.secondartColor.withOpacity(.60),
          fontSize: 16.0,
          fontFamily: UIFont.galano,
        ),
        fillColor: UIColor.white,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: border ?? InputBorder.none,
        border: border?? InputBorder.none,
        focusedBorder: border?? InputBorder.none,
        
      ),
    );
  }
}
