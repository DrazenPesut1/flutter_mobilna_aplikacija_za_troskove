import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  width: 65, 
                  height: 65, 
                  decoration: BoxDecoration(  
                    borderRadius: BorderRadius.circular(20),  
                  ),
                  child: ElevatedButton(
                    onPressed: function, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkerGray,
                      elevation: 0, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),  
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: button_icon.icon != FontAwesomeIcons.moneyBillTransfer 
                    ? button_icon
                    : Padding(padding: EdgeInsets.only(right: 6.5), child: button_icon,)
                  ),
                ),
    const SizedBox(height: 8,),
    Text(button_label, style: NormalVariableFontTextStyle(color: Colors.black, fontSize: 14).textStyle)]);
  }
}