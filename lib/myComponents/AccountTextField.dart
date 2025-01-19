import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';

class AccountTextField extends StatelessWidget{
  final String hint;
  final TextEditingController textEditingController;
  const AccountTextField({required this.hint, required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: AppColors.darkerGray,
        hintText: hint,
        hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 14).textStyle,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(width: 1)),
      )
    );
  }
}