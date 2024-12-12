import 'package:expense_tracker/myComponents/MyAddAccountButton.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyColorBox.dart';
import 'package:expense_tracker/myComponents/MyPlusButton.dart';

class SavingsAccountPage extends StatefulWidget{
  const SavingsAccountPage({super.key});

  @override
  State<SavingsAccountPage> createState() => _SavingsAccountPageState();
}

class _SavingsAccountPageState extends State<SavingsAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          MyAddAccountButton(account_type: 'Savings')
        ],
      )
    );
  }
}