// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/app_fonts.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';

abstract class MyCard extends StatefulWidget {
  final String card_title;
  final String card_subtitle;
  final IconData card_icon;
  final Color card_color;
  

  const MyCard({
    super.key, 
    required this.card_title,
    required this.card_subtitle,
    required this.card_icon,
    required this.card_color
    }
  );
}

class MyAccountCard extends MyCard {
  // ignore: constant_identifier_names
  static const account_card_subtitle = 'Current balance: ';

  const MyAccountCard({super.key, 
    required super.card_title, 
    required super.card_icon, 
    required super.card_color,
  }) : super(card_subtitle: account_card_subtitle);

  @override
  _MyAccountCardState createState() => _MyAccountCardState();
}

class _MyAccountCardState extends State<MyAccountCard> {
  bool isExpanded = false;
  

  @override
  Widget build(BuildContext context) {
    return Card(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          color: AppColors.offWhite,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(style: BorderStyle.solid, color: Colors.grey)
            ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListTile(
              leading: Icon(widget.card_icon, size: 45, color: widget.card_color,),
              title: Text(widget.card_title, style: BoldBodyTextStyle(color: Colors.black).textStyle),
              subtitle: Text.rich(TextSpan(children: [
            TextSpan(text: widget.card_subtitle, style: NormalBodyTextStyle(color: Colors.black).textStyle,),
            TextSpan(text: '  500.00' '€', style: MoneyBodyTextStyle(color: AppColors.moneyPositive).textStyle) , 
                    ]))
                  ),
          ),
    );
  }
}



