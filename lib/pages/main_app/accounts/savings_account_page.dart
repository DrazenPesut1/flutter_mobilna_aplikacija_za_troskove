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
import 'package:expense_tracker/myComponents/MyAddAccountButton.dart';

class SavingsAccountPage extends StatefulWidget{
  const SavingsAccountPage({super.key});

  @override
  State<SavingsAccountPage> createState() => _SavingsAccountPageState();
}

class _SavingsAccountPageState extends State<SavingsAccountPage> {
  double initial_amount = 0;
  double goal = 0;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  double progress = 450;

  void updateProgressBar(){
    setState(() {
      if(goal == 0 || initial_amount == 0){
        progress = 0;
      } else if(goal > initial_amount){
        progress = (initial_amount * 1.0 / goal) * 100.0;
      } else if(goal <= initial_amount){
        progress = 100.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Card(
              color: AppColors.offWhite,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1.4, 
                  style: BorderStyle.solid, 
                  color: Colors.black
                ),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SONY Camera", style: BoldBodyTextStyle(color: Colors.black).textStyle,),
                        Text("450 € / 1000 €", style: NormalBodyTextStyle(color: Colors.black).textStyle,),
                      ],
                    ),
                    SizedBox(
                      height: 90, // Increase height here
                      width: 90,
                      child: DashedCircularProgressBar.aspectRatio(
                        aspectRatio: 1, // width ÷ height
                        valueNotifier: _valueNotifier,
                        progress: 45,
                        startAngle: 0,
                        sweepAngle: 360,
                        foregroundColor: Colors.blue,
                        backgroundColor: const Color(0xffeeeeee),
                        foregroundStrokeWidth: 10,
                        backgroundStrokeWidth: 10,
                        animation: true,
                        seekSize: 6,
                        seekColor: const Color(0xffeeeeee),
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: _valueNotifier,
                            builder: (_, double value, __) => const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.camera_alt_rounded, size: 35, color: Colors.blue,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            
            ),
          ),
          MyAddAccountButton(account_type: 'Savings', function: () {
            
          },)
        ],
      )
    );
  }
}