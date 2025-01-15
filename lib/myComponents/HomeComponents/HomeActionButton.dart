import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomeActionButton extends StatelessWidget{
  final String button_label;
  final Icon button_icon;
  final VoidCallback function;
  const HomeActionButton(
    this.button_icon,
    this.button_label,
    this.function, 
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                Container(
                  width: 60,  // Set the container width for the button
                  height: 60,  // Set the container height for the button
                  decoration: BoxDecoration(
                    color: AppColors.offWhite,  // Set the background color to white
                    borderRadius: BorderRadius.circular(15),  // Rounded corners
                    border: Border.all(color: Colors.grey),  // Set the border color to gray
                  ),
                  child: ElevatedButton(
                    onPressed: function, 
                    style: ElevatedButton.styleFrom(
                      elevation: 0,  // Remove the default shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),  // Rounded corners
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: button_icon
                  ),
                ),
    const SizedBox(height: 3,),
    Text(button_label, style: MoneyBodyTextStyle(color: AppColors.textGray, fontSize: 13).textStyle,),]);
  }
}