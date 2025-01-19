import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final String label;
  final IconData icon;
  final bool isPassword;
  const MyTextField(this.label, this.icon, this.isPassword, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: label,
        hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 15).textStyle,
        filled: true,
        fillColor: AppColors.darkerGray,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.4)),
      )
    );
  }
}