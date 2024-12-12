import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class MyPlusButton extends StatelessWidget{
  final Function function_;
  const MyPlusButton({required this.function_ , super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 90,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.offWhite,
        ), 
        child: const Icon(Ionicons.add_sharp, size: 40,)
      ),
    );
  }
}