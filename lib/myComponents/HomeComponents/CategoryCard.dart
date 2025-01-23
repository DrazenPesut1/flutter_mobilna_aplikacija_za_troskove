import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';

abstract class CategoryCard extends StatefulWidget{
  final String category_name;
  final IconData category_icon;
  final Color category_color;

  const CategoryCard(
    {super.key,
      required this.category_name,
      required this.category_icon,
      required this.category_color,
    }
  );
}

class ExpenseCategoryCard extends CategoryCard {
  double category_expense;

  ExpenseCategoryCard({
    super.key,
    required super.category_name, 
    required super.category_icon,
    required super.category_color,
    this.category_expense = 0.0,
  });

  @override
  State<ExpenseCategoryCard> createState() => _ExpenseCategoryCardState();
}

class _ExpenseCategoryCardState extends State<ExpenseCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.darkerGray,
          borderRadius: BorderRadius.circular(18)
        ),
        child: Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: Icon(widget.category_icon, size: 28, color: widget.category_color,),
            title: Text(widget.category_name, style: NormalVariableFontTextStyle(color: Colors.black, fontSize: 16).textStyle,),
            trailing: Text('${widget.category_expense.toStringAsFixed(2)} EUR', style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,),
          ),
        ),
      ),
    );
  }
}

class IncomeCategoryCard extends CategoryCard {
  double category_income;

  IncomeCategoryCard({
    super.key,
    required super.category_name, 
    required super.category_icon,
    required super.category_color,
    this.category_income = 0.0,
  });

  @override
  State<IncomeCategoryCard> createState() => _IncomeCategoryCardState();
}

class _IncomeCategoryCardState extends State<IncomeCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.darkerGray,
          borderRadius: BorderRadius.circular(18)
        ),
        child: Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: Icon(widget.category_icon, size: 28, color: widget.category_color,),
            title: Text(widget.category_name, style: NormalVariableFontTextStyle(color: Colors.black, fontSize: 16).textStyle,),
            trailing: Text('${widget.category_income.toStringAsFixed(2)} EUR', style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,),
          ),
        ),
      ),
    );
  }
}

