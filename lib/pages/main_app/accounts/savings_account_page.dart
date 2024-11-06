import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';

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
      body: Center(child: Text("Savings accounts"),),
    );
  }
}