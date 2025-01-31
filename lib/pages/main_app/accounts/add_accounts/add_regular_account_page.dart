// ignore_for_file: deprecated_member_use

import 'package:expense_tracker/myComponents/AccountTextField.dart';
import 'package:expense_tracker/myComponents/RoundedActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddRegularAccountPage extends StatefulWidget {
  const AddRegularAccountPage({super.key});

  @override
  State<AddRegularAccountPage> createState() => _AddRegularAccountPageState();
}

class _AddRegularAccountPageState extends State<AddRegularAccountPage> {
  Color selectedColor = Colors.blue;
  Icon selectedIcon = const Icon(
    FontAwesomeIcons.ccVisa,
    size: 35.0,
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
                  selectedIcon = Icon(
                    selectedIcon.icon, 
                    color: selectedColor,
                    size: 35.0,
                  );
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Select',
                style: NormalVariableFontTextStyle(color: Colors.black, fontSize: 18).textStyle,
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
        iconPackModes: [IconPack.fontAwesomeIcons],
        iconPickerShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Pick an icon',
            style: BoldHeaderTextStyle(color: Colors.black).textStyle,
          ),
        ),
        closeChild: Text(
          'Select',
          style: NormalVariableFontTextStyle(color: Colors.black, fontSize: 18).textStyle,
        ),
      ),
    );

    if (icon != null) {
      setState(() {
        selectedIcon = Icon(
          icon.data,
          color: selectedColor,
          size: 35.0,
        );
      });
      debugPrint("Set codepoint: ${selectedIcon.icon!.codePoint}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.offWhite,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back),
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
        child: Column(
          children: [Container(
            margin: const EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: AppColors.offWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Account Name",
                      style: BoldBodyTextStyle(color: Colors.black).textStyle,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  AccountTextField(hint: "Account Name", textEditingController: accountNameController),
                  const SizedBox(height: 15.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Description",
                      style: BoldBodyTextStyle(color: Colors.black).textStyle,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  AccountTextField(hint: "Short note...", textEditingController: descriptionController),
                  const SizedBox(height: 15.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(child: Text("Pick Icon", style: BoldBodyTextStyle(color: Colors.black).textStyle, textAlign: TextAlign.center,)),
                            Expanded(child: Text("Pick Color",style: BoldBodyTextStyle(color: Colors.black).textStyle, textAlign: TextAlign.center,),)
                          ],),
                          const SizedBox(height: 5.0),
                          Row(children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: openIconPicker,
                                child: Container(
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: AppColors.darkerGray,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      bottomLeft: Radius.circular(18)
                                    ),
                                    border: Border(
                                      right: BorderSide(
                                        color: AppColors.textGray,
                                        width: 1
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: selectedIcon,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: openColorPicker,
                                child: Container(
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: AppColors.darkerGray,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(18),
                                      bottomRight: Radius.circular(18)
                                    ),
                                    border: Border(
                                      left: BorderSide(
                                        color: AppColors.textGray,
                                        width: 1.2
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Icon(FontAwesomeIcons.droplet, size: 33, color: selectedColor,),
                                  ),
                                ),
                              ),
                            )
                          ],),
                        ],
                      ),
                    ),
                  const SizedBox(height: 25.0),
                  Column(
                    children: [
                      Text(
                        "Initial Balance (EUR): ",
                        style: BoldBodyTextStyle(color: Colors.black).textStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: initialBalanceController,
                        textAlign: TextAlign.center,
                        style: MoneyBodyTextStyle(color: Colors.black, fontSize: 22).textStyle,
                        decoration: InputDecoration(
                          fillColor: AppColors.darkerGray,
                          hintText: "0,00",
                          hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 22).textStyle,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide(width: 1)),
                        ),
                        keyboardType:
                    TextInputType.numberWithOptions(decimal: true, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+(\.\d{0,2})?$')),
                ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  RoundedActionButton(
                      function: () {
                        final accountData = {
                          'accountName': accountNameController.text,
                          'description': descriptionController.text,
                          'initialBalance': double.tryParse(initialBalanceController.text) ?? 0.0,
                          'selectedIcon': selectedIcon.icon!.codePoint,
                          'selectedIconFamily' : selectedIcon.icon!.fontFamily, 
                          'selectedColor': selectedColor.value,
                        };

                        if(accountNameController.text == ''){
                          AlertDialog(actions: [Text("Please fill select an account name")],);
                        } else {
                          Navigator.pop(context, accountData);
                        }
              }, label: 'Add',),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: AppColors.offWhite,
          )
        ]),
      ),
    );
  }
}
