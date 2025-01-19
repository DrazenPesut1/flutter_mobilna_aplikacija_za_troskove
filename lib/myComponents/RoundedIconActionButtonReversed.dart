import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';

class RoundedIconActionButton extends StatelessWidget {
  final VoidCallback function;
  final String label;
  final Color color; 

  const RoundedIconActionButton({
    required this.function,
    required this.label,
    required this.color, 
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          foregroundColor: AppColors.offWhite, 
          backgroundColor: color, 
        ),
        child: Center(
          child: Text(
            label,
            style: BoldVariableFontTextStyle(color: AppColors.offWhite, fontSize: 18).textStyle, 
          ),
        ),
      ),
    );
  }
}
