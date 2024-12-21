import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyColorBox.dart';
import 'package:expense_tracker/myComponents/MyPlusButton.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddRegularAccountPage extends StatefulWidget {
  const AddRegularAccountPage({super.key});

  @override
  State<AddRegularAccountPage> createState() => _AddRegularAccountPageState();
}

class _AddRegularAccountPageState extends State<AddRegularAccountPage> {
  Color selectedColor = Colors.blue;
  Icon? selectedIcon = const Icon(
    Icons.credit_card_rounded,
    size: 45.0,
    color: Colors.blue,
  );

  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController initialBalanceController = TextEditingController();

  void openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Align(
              alignment: Alignment.center, child: Text('Pick a color')),
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
        selectedIcon = Icon(
          icon.data,
          color: selectedColor,
          size: 45.0,
        );
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
          "Add Regular Account",
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
                  hintText: "Card, cash...",
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
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
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          width: 125,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(width: 1.2, color: Colors.grey),
                          ),
                          child: Center(
                            child: selectedIcon ??
                                const Icon(Icons.credit_card_rounded), // Default fallback
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
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
                          width: 125,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(width: 1.2, color: Colors.grey),
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
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Column(
                  children: [
                    Text(
                      "Initial Balance (€): ",
                      style: NormalBodyTextStyle(color: Colors.black).textStyle,
                    ),
                    const SizedBox(width: 15.0),
                    TextField(
                      controller: initialBalanceController,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 35.0,
                          color: Colors.black),
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
              const SizedBox(
                height: 30.0,
              ),
              MyPlusButton(
                  function_: () {
                    // Prepare the data to pass back
                    final accountData = {
                      'accountName': accountNameController.text,
                      'description': descriptionController.text,
                      'initialBalance': initialBalanceController.text,
                      'selectedIcon': selectedIcon,
                      'selectedColor': selectedColor,
                    };

                    // Pop and pass the data back
                    Navigator.pop(context, accountData);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
