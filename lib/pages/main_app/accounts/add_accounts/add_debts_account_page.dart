import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyColorBox.dart';
import 'package:expense_tracker/myComponents/MyPlusButton.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';

class AddDebtsAccountPage extends StatefulWidget{
  const AddDebtsAccountPage({super.key});

  @override
  State<AddDebtsAccountPage> createState() => _AddDebtsAccountPageState();
}

class _AddDebtsAccountPageState extends State<AddDebtsAccountPage>{
  Color selectedColor = Colors.blue;
  Icon? selectedIcon = const Icon(Icons.car_repair_rounded, size: 45.0, color: Colors.blue,);
  double initial_amount = 0;
  double goal = 0;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  double progress = 0;

  String? selectedType = 'I owe';

  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController initialPaidOffAmountController = TextEditingController();
  final TextEditingController debtGoalAmountController = TextEditingController();

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

  void openColorPicker() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Align(alignment: Alignment.center, child: Text('Pick a color')),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: selectedColor,
            onColorChanged: (Color color) {
              setState(() {
                selectedColor = color;
                // Update the icon color dynamically
                if (selectedIcon != null) {
                  selectedIcon = Icon(
                    selectedIcon!.icon, // Retain the existing icon data
                    color: selectedColor,
                    size: 45.0,
                  );
                }
              });
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Select',
              style: NormalBodyTextStyle(color: Colors.black).textStyle,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  void openIconPicker() async {
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPackModes: [IconPack.roundedMaterial],
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Pick an icon',
            style: NormalHeaderTextStyle(color: Colors.black).textStyle,
          ),
        ),
        closeChild: Text(
          'Select',
          style: NormalBodyTextStyle(color: AppColors.primary).textStyle,
        ),
      ),
    );

    if (icon != null) {
      setState(() {
        selectedIcon = Icon(icon.data, color: selectedColor, size: 45.0,);
      });
      debugPrint('Picked Icon: $icon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.offWhite,
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back),
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Add Debts Account",
          style: BoldHeaderTextStyle(color: AppColors.offWhite).textStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Account Name",
                  style: NormalBodyTextStyle(color: Colors.black).textStyle,
                ),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: accountNameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                  hintText: "Car payment, mortgage, small loan...",
                  hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 15.0),
                  filled: true,
                  fillColor: AppColors.offWhite,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Description",
                  style: NormalBodyTextStyle(color: Colors.black).textStyle,
                ),
              ),
              const SizedBox(height: 5.0),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                  hintText: "What is your account used for...",
                  hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 15.0),
                  filled: true,
                  fillColor: AppColors.offWhite,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1.4,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "Choose icon:",
                        style: NormalBodyTextStyle(color: Colors.black).textStyle,
                      ),
                      const SizedBox(height: 5.0),
                  GestureDetector(
                    onTap: openIconPicker,
                    child: Container(
                      width: 140,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(width: 1.4, color: Colors.grey),
                      ),
                      child: Center(
                        child: selectedIcon ?? const Icon(Icons.credit_card_rounded), // Default fallback
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Icon color:",
                    style: NormalBodyTextStyle(color: Colors.black).textStyle,
                  ),
                  const SizedBox(height: 5.0),
                  GestureDetector(
                    onTap: openColorPicker,
                    child: Container(
                      width: 140,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(width: 1.4, color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyColorBox(color_: selectedColor),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
                    ],
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(                 
                    width: 140.0,
                    child: RadioMenuButton(
                      value: "I owe", 
                      groupValue: selectedType, 
                      onChanged: (selectedValue){
                        setState(() {
                          selectedType = selectedValue;
                        });
                      },
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey, width: 1.4, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12.0))
                        )
                      ),
                      child: Text('I owe', style: NormalBodyTextStyle(color: Colors.black).textStyle,)
                    ),
                  ),
                  SizedBox(
                    width: 140.0,
                    child: RadioMenuButton(
                      value: "I am owed", 
                      groupValue: selectedType, 
                      onChanged: (selectedValue){
                        setState(() {
                          selectedType = selectedValue;
                        });
                      },
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey, width: 1.4, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12.0))
                        )
                      ),
                      child: Text('I am owed', style: NormalBodyTextStyle(color: Colors.black).textStyle,)
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [SizedBox(
                  width: 155,
                  child: Column(
                    children: [
                      Text(
                        "Initial amount (€): ",
                        style: NormalBodyTextStyle(color: Colors.black).textStyle,
                      ),
                      const SizedBox(width: 15.0),
                      TextField(
                        controller: initialPaidOffAmountController,
                        onSubmitted: (value){
                          setState(() {
                            initial_amount = double.tryParse(value)!;
                            updateProgressBar();
                          }
                        );
                        },
                        style: const TextStyle(fontFamily: 'Poppins', fontSize: 35.0, color: Colors.black),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "0",
                          hintStyle:
                              TextStyle(fontFamily: 'Poppins', fontSize: 35.0),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          filled: true,
                          fillColor: AppColors.offWhite,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 155,
                  child: Column(
                    children: [
                      Text(
                        "Goal: ",
                        style: NormalBodyTextStyle(color: Colors.black).textStyle,
                      ),
                      const SizedBox(width: 15.0),
                      TextField(
                        controller: debtGoalAmountController,
                        onSubmitted: (value){
                          setState(() {
                            goal = double.tryParse(value)!;
                            updateProgressBar();
                          });
                        },
                        style: const TextStyle(fontFamily: 'Poppins', fontSize: 35.0, color: Colors.black),
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "0",
                          hintStyle:
                              TextStyle(fontFamily: 'Poppins', fontSize: 35.0),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          filled: true,
                          fillColor: AppColors.offWhite,
                        ),
                      ),
                    ],
                  ),
                ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: 120,
                height: 120,
                child: DashedCircularProgressBar.aspectRatio(
                  aspectRatio: 1, // width ÷ height
                  valueNotifier: _valueNotifier,
                  progress: progress,
                  startAngle: 0,
                  sweepAngle: 360,
                  foregroundColor: selectedColor,
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
                          Text(
                            '${value.toInt()}%',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 30
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              MyPlusButton(function_: () {
                final accountData = {
                  'accountName': accountNameController.text,
                  'description': descriptionController.text,
                  'initialPaidOffAmount': double.tryParse(initialPaidOffAmountController.text) ?? 0.0,
                  'debtGoalAmount': double.tryParse(debtGoalAmountController.text) ?? 0.0,
                  'selectedIcon': selectedIcon,
                  'selectedColor': selectedColor,
                  'selectedType': selectedType
                };

                Navigator.pop(context, accountData);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
  