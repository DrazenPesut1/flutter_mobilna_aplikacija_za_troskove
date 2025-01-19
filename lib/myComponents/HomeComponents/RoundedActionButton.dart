import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';

class RoundedActionButton extends StatelessWidget{
  VoidCallback function;
  String label;
  RoundedActionButton({required this.function, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
          ),
          elevation: 0,
          foregroundColor: AppColors.offWhite,
          backgroundColor: AppColors.primary
        ), 
        child: Text(label, style: BoldVariableFontTextStyle(color: AppColors.offWhite, fontSize: 18).textStyle,)
      ),
    );
  }
}