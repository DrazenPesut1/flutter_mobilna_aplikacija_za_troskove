import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        title: const Text("0€", style: TextStyle(fontSize: 30),),
        centerTitle: true,
      )
    );
  }
}