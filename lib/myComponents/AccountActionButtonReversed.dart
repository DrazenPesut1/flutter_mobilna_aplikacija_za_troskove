import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';

class AccountActionButtonReversed extends StatelessWidget {
  final VoidCallback function;
  final String label;
  final Color color; 

  const AccountActionButtonReversed({
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
            side: BorderSide(color: color, width: 2), 
          ),
          elevation: 0,
          foregroundColor: color, 
          backgroundColor: Colors.white, 
        ),
        child: Center(
          child: Text(
            label,
            style: BoldVariableFontTextStyle(color: color, fontSize: 18).textStyle, 
          ),
        ),
      ),
    );
  }
}
