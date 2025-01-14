// ignore_for_file: must_be_immutable

import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ExpenseCategoryCard extends StatefulWidget {
  final String category_name;
  final IconData category_icon;
  double category_expense = 0;
  final Color category_color;
  ExpenseCategoryCard({
    required this.category_name, 
    required this.category_icon,
    required this.category_color,
    super.key
  });

  @override
  State<ExpenseCategoryCard> createState() => _ExpenseCategoryCardState();
}

class _ExpenseCategoryCardState extends State<ExpenseCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
              children: [
                Expanded(
                  child: Container(
                    height: 58,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: ListTile(
                        leading: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            border: Border.all(color: widget.category_color, width: 1.2),
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Align(alignment: Alignment.center ,child: Icon(widget.category_icon, size: 30, color: widget.category_color,))),
                        title: Text(widget.category_name, style: BoldBodyTextStyle(color: Colors.black).textStyle,),
                        trailing: Text('${widget.category_expense.toStringAsFixed(2)} EUR', style: BoldHeaderTextStyle(color: Colors.black).textStyle,),
                      ),
                    ),
                  ),
                ),
              ],
          );
  }
}