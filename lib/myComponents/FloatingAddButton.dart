import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';

class FloatingAddButton extends StatelessWidget {
  final VoidCallback function;

  const FloatingAddButton({
    required this.function,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 80,
      child: FloatingActionButton(
        onPressed: function,
        backgroundColor: AppColors.primary,
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ), 
        child: Text(
          'Add',
          style: BoldVariableFontTextStyle(color: AppColors.offWhite, fontSize: 16).textStyle,
        ),
      ),
    );
  }
}