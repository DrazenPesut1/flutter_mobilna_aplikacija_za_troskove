// ignore: file_names
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';

class MyButton extends StatelessWidget{
  final String text;
  final double width;
  final VoidCallback action;
  const MyButton(this.text, this.width, this.action, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: 45.0,
        child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          elevation: 0,
        foregroundColor: AppColors.offWhite,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 21),
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)))),
        child: Text(text, style: BoldVariableFontTextStyle(color: AppColors.offWhite, fontSize: 18).textStyle,),
      ),
    );
  }
}