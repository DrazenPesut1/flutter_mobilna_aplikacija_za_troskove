import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MyAddAccountButton extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String account_type;
  final VoidCallback function;
  // ignore: non_constant_identifier_names
  const MyAddAccountButton({required this.account_type, required this.function, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAddAccountButtonState createState() => _MyAddAccountButtonState();
}

class _MyAddAccountButtonState extends State<MyAddAccountButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.function,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.offWhite,
          backgroundColor: AppColors.primary
        ), 
        child: Text("Add ${widget.account_type} Account", style: NormalBodyTextStyle(color: AppColors.offWhite).textStyle,)
      ),
    );
  }
}