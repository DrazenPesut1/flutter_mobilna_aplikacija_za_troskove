import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';

class RoundedCreateButton extends StatelessWidget{
  VoidCallback function;
  RoundedCreateButton({required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.offWhite,
          backgroundColor: AppColors.primary
        ), 
        child: Text("Create", style: BoldBodyTextStyle(color: AppColors.offWhite).textStyle,)
      ),
    );
  }
}