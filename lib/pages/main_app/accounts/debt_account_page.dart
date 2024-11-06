import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';

class DebtsAccountPage extends StatefulWidget{
  const DebtsAccountPage({super.key});

  @override
  State<DebtsAccountPage> createState() => _DebtsAccountPageState();
}

class _DebtsAccountPageState extends State<DebtsAccountPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(children: [
        
      ],) 
    );
  }
}