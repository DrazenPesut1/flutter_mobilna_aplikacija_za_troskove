// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyColorBox.dart';
import 'package:expense_tracker/myComponents/MyPlusButton.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';


abstract class MyCard extends StatefulWidget {
  final String card_title;
  final String card_description;
  final String card_subtitle;
  final double card_balance;
  final Icon card_icon;
  final Color card_color;

  const MyCard(
      {super.key,
      required this.card_title,
      required this.card_description,
      required this.card_balance,
      required this.card_subtitle,
      required this.card_icon,
      required this.card_color});
}

class MyRegularAccountCard extends MyCard {
  // ignore: constant_identifier_names
  static const account_card_subtitle = 'Current balance: ';

  const MyRegularAccountCard({
    super.key,
    required super.card_title,
    required super.card_description,
    required super.card_balance,
    required super.card_icon,
    required super.card_color,
  }) : super(card_subtitle: account_card_subtitle);

  @override
  _MyRegularAccountCardState createState() => _MyRegularAccountCardState();
}

class _MyRegularAccountCardState extends State<MyRegularAccountCard> {
  bool isExpanded = false;
 
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: AppColors.offWhite,
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(style: BorderStyle.solid, color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListTile(
            leading: widget.card_icon,
            title: Text(widget.card_title,
                style: BoldBodyTextStyle(color: Colors.black).textStyle),
            subtitle: Text.rich(TextSpan(children: [
              TextSpan(
                text: widget.card_subtitle,
                style: NormalBodyTextStyle(color: Colors.black).textStyle,
              ),
              TextSpan(
                  text: '${widget.card_balance}',
                  style: MoneyBodyTextStyle(color: AppColors.moneyPositive, fontSize: 19.0)
                      .textStyle),
            ]))),
      ),
    );
  }
}

class MySavingsAccountCard extends MyCard {
  // ignore: constant_identifier_names
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

  @override
  _MySavingsAccountCardState createState() => _MySavingsAccountCardState();
}

class _MySavingsAccountCardState extends State<MySavingsAccountCard> {
  double initial_amount = 0; // Starting amount
  double goal = 0; // Goal to achieve
  late ValueNotifier<double> _valueNotifier;

  @override
  void initState() {
    super.initState();
    // Initialize ValueNotifier with the initial progress
    _valueNotifier = ValueNotifier(widget.progress);
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
      // Update the ValueNotifier with the new progress value
      _valueNotifier.value = widget.progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        color: AppColors.offWhite,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              width: 1.4, style: BorderStyle.solid, color: Colors.black),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.card_title,
                    style: BoldBodyTextStyle(color: Colors.black).textStyle,
                  ),
                  Text(
                    widget.card_subtitle,
                    style: NormalBodyTextStyle(color: Colors.black).textStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 90, // Increased height
                width: 90,
                child: DashedCircularProgressBar.aspectRatio(
                  aspectRatio: 1, // width ÷ height
                  valueNotifier: _valueNotifier,
                  progress: widget.progress,
                  startAngle: 0,
                  sweepAngle: 360,
                  foregroundColor: widget.card_color,
                  backgroundColor: const Color(0xffeeeeee),
                  foregroundStrokeWidth: 10,
                  backgroundStrokeWidth: 10,
                  animation: true,
                  seekSize: 6,
                  seekColor: const Color(0xffeeeeee),
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: _valueNotifier,
                      builder: (_, double value, __) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            size: 35,
                            color: widget.card_color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDebtsAccountCard extends MyCard {
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
  double initial_amount = 0; // Starting amount
  double goal = 0; // Goal to achieve
  late ValueNotifier<double> _valueNotifier;

  

  @override
  void initState() {
    super.initState();
    // Initialize ValueNotifier with the initial progress
    _valueNotifier = ValueNotifier(widget.progress);
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
      // Update the ValueNotifier with the new progress value
      _valueNotifier.value = widget.progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        color: AppColors.offWhite,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              width: 1.4, style: BorderStyle.solid, color: Colors.black),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.card_title,
                    style: BoldBodyTextStyle(color: Colors.black).textStyle,
                  ),
                  Text(
                    widget.type == 'I owe' ? 'I owe ${widget.goal - widget.card_balance} more' : 'I am owed ${widget.goal - widget.card_balance} more',
                    style: NormalBodyTextStyle(color: Colors.black).textStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 90, // Increased height
                width: 90,
                child: DashedCircularProgressBar.aspectRatio(
                  aspectRatio: 1, // width ÷ height
                  valueNotifier: _valueNotifier,
                  progress: widget.progress,
                  startAngle: 0,
                  sweepAngle: 360,
                  foregroundColor: widget.card_color,
                  backgroundColor: const Color(0xffeeeeee),
                  foregroundStrokeWidth: 10,
                  backgroundStrokeWidth: 10,
                  animation: true,
                  seekSize: 6,
                  seekColor: const Color(0xffeeeeee),
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: _valueNotifier,
                      builder: (_, double value, __) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            size: 35,
                            color: widget.card_color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}