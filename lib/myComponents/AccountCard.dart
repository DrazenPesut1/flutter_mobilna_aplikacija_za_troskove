// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';

abstract class AccountCard extends StatefulWidget {
  final String card_title;
  final String card_description;
  final String card_subtitle;
  double card_balance;
  final Icon card_icon;
  final Color card_color;

  AccountCard(
      {super.key,
      required this.card_title,
      required this.card_description,
      required this.card_balance,
      required this.card_subtitle,
      required this.card_icon,
      required this.card_color}
    );
}

class MyRegularAccountCard extends AccountCard {
  static const account_card_subtitle = 'Account balance: ';

  MyRegularAccountCard({
    super.key,
    required super.card_title,
    required super.card_description,
    required super.card_balance,
    required super.card_icon,
    required super.card_color,
  }) : super(card_subtitle: account_card_subtitle);

  void addBalance(double amount){
    card_balance += amount;
  }

  void removeBalance(double amount){
    card_balance -= amount;
  }

  void transferMoney(MyRegularAccountCard transferCard, double amount){
    card_balance -= amount;
    transferCard.card_balance += amount;
  }

  @override
  _MyRegularAccountCardState createState() => _MyRegularAccountCardState();
}

class _MyRegularAccountCardState extends State<MyRegularAccountCard> {
  bool isExpanded = false;
  
  NumberFormat formatter = NumberFormat.currency(locale: "de_DE", decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.all(0.0),
              height: 150,
              width: double.infinity,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                color: AppColors.offWhite,
                elevation: 3,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 7,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: widget.card_color,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12.0))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 3.0),
                      child: ListTile(
                          leading: widget.card_icon,
                          title: Text(widget.card_title,
                              style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 16).textStyle),
                          trailing: IconButton(
                            onPressed: (){}, 
                            icon: Icon(Ionicons.ellipsis_horizontal, color: AppColors.textGray, size: 30,),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        leading: Text(widget.card_subtitle, style: NormalBodyTextStyle(color: Colors.black).textStyle,),
                        trailing: Text(formatter.format(widget.card_balance), style: MoneyBodyTextStyle(color: Colors.black, fontSize: 20).textStyle,),
                      ),
                    )
                  ],
                ),
              ),
            );
  }
}

class MySavingsAccountCard extends AccountCard {
  static const account_card_subtitle = 'Left to goal: ';
  late double progress;
  late double goal;

  MySavingsAccountCard({
    super.key,
    required super.card_title,
    required super.card_description,
    required super.card_balance,
    required this.goal,
    required super.card_icon,
    required super.card_color,
    required this.progress,
  }) : super(card_subtitle: account_card_subtitle);

  void addBalance(double amount){
    card_balance += amount;
  }

  void removeBalance(double amount){
    card_balance -= amount;
  }

  @override
  _MySavingsAccountCardState createState() => _MySavingsAccountCardState();
}

class _MySavingsAccountCardState extends State<MySavingsAccountCard> {
  NumberFormat formatter = NumberFormat.currency(locale: "de_DE", decimalDigits: 2);
  double initial_amount = 0; 
  double goal = 0; 
  String currency = 'EUR';
  late ValueNotifier<double> _valueNotifier;

  @override
    void initState() {
      super.initState();
      widget.progress = widget.goal > 0 ? (widget.card_balance / widget.goal) * 100 : 0;
      _valueNotifier = ValueNotifier(widget.progress.clamp(0, 100));
  }

  @override
Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(0.0),
    height: 170,
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: AppColors.offWhite,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Container(
            height: 7,
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.card_color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.card_title,
                            style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 16).textStyle,
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(formatter.format(widget.goal), style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,),
                              Text.rich(
                                TextSpan(
                                  text: "Saved:  ",
                                  style: NormalBodyTextStyle(color: Colors.black).textStyle,
                                  children: [
                                    TextSpan(
                                      text: formatter.format(widget.card_balance),
                                      style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,
                                    )
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "To goal:  ",
                                  style: NormalBodyTextStyle(color: Colors.black).textStyle,
                                  children: [
                                    TextSpan(
                                      text: formatter.format(widget.goal - widget.card_balance),
                                      style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: DashedCircularProgressBar.aspectRatio(
                        aspectRatio: 1,
                        valueNotifier: _valueNotifier,
                        progress: _valueNotifier.value,
                        startAngle: 225,
                        sweepAngle: 270,
                        foregroundColor: widget.card_color,
                        backgroundColor: const Color(0xffeeeeee),
                        foregroundStrokeWidth: 6,
                        backgroundStrokeWidth: 6,
                        animation: true,
                        seekSize: 12,
                        seekColor: Colors.black,
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: _valueNotifier,
                            builder: (_, double value, __) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.card_icon,
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${value.toStringAsFixed(0)}%',
                                  style: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 14).textStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}

class MyDebtsAccountCard extends AccountCard {
  // ignore: constant_identifier_names
  static const account_card_subtitle = 'I owe';
  late double progress;
  late double goal;
  late String type;

  MyDebtsAccountCard({
    super.key,
    required super.card_title,
    required super.card_description,
    required super.card_balance,
    required this.goal,
    required this.type,
    required super.card_icon,
    required super.card_color,
    required this.progress,
  }) : super(card_subtitle: account_card_subtitle);

  @override
  _MyDebtsAccountCardState createState() => _MyDebtsAccountCardState();
}

class _MyDebtsAccountCardState extends State<MyDebtsAccountCard> {
  double initial_amount = 0;
  double goal = 0;
  late ValueNotifier<double> _valueNotifier;
  NumberFormat formatter = NumberFormat.currency(locale: "de_DE", decimalDigits: 2);
  

  @override
  void initState() {
    super.initState();
    widget.progress = widget.goal > 0 ? (widget.card_balance / widget.goal) * 100 : 0;
    _valueNotifier = ValueNotifier(widget.progress.clamp(0, 100));
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  void updateProgressBar() {
    setState(() {
      if (goal == 0 || initial_amount == 0) {
        widget.progress = 0;
      } else if (goal > initial_amount) {
        widget.progress = (initial_amount * 1.0 / goal) * 100.0;
      } else if (goal <= initial_amount) {
        widget.progress = 100.0;
      }
      _valueNotifier.value = widget.progress;
    });
  }

  @override
  Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(0.0),
    height: 170,
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: AppColors.offWhite,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Container(
            height: 7,
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.card_color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.card_title,
                            style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 16).textStyle,
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(formatter.format(widget.goal), style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,),
                              Text.rich(
                                TextSpan(
                                  text: "Returned:  ",
                                  style: NormalBodyTextStyle(color: Colors.black).textStyle,
                                  children: [
                                    TextSpan(
                                      text: formatter.format(widget.card_balance),
                                      style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,
                                    )
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: widget.type == 'I owe' ? 'I owe ' : 'I am owed ',
                                      style: NormalBodyTextStyle(color: Colors.black).textStyle,
                                    ),
                                    TextSpan(
                                      text: formatter.format(widget.goal - widget.card_balance),
                                      style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,
                                    ),
                                    TextSpan(
                                      text: widget.type == 'I owe' ? ' more' : ' more',
                                      style: NormalBodyTextStyle(color: Colors.black).textStyle,
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: DashedCircularProgressBar.aspectRatio(
                        aspectRatio: 1,
                        valueNotifier: _valueNotifier,
                        progress: _valueNotifier.value,
                        startAngle: 225,
                        sweepAngle: 270,
                        foregroundColor: widget.card_color,
                        backgroundColor: const Color(0xffeeeeee),
                        foregroundStrokeWidth: 6,
                        backgroundStrokeWidth: 6,
                        animation: true,
                        seekSize: 12,
                        seekColor: Colors.black,
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: _valueNotifier,
                            builder: (_, double value, __) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.card_icon,
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${value.toStringAsFixed(0)}%',
                                  style: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 14).textStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
