import 'package:expense_tracker/myComponents/AccountTextField.dart';
import 'package:expense_tracker/myComponents/RoundedActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

class AddDebtsAccountPage extends StatefulWidget{
  const AddDebtsAccountPage({super.key});

  @override
  State<AddDebtsAccountPage> createState() => _AddDebtsAccountPageState();
}

class _AddDebtsAccountPageState extends State<AddDebtsAccountPage>{
  Color selectedColor = Colors.blue;
  Icon? selectedIcon = const Icon(FontAwesomeIcons.ticket, size: 35.0, color: Colors.blue,);
  double initial_amount = 0;
  double goal = 0;
  double progress = 0;

  String? selectedType = 'I owe';

  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController initialPaidOffAmountController = TextEditingController();
  final TextEditingController debtGoalAmountController = TextEditingController();

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
                if (selectedIcon != null) {
                  selectedIcon = Icon(
                    selectedIcon!.icon, 
                    color: selectedColor,
                    size: 35.0,
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
        iconPackModes: [IconPack.fontAwesomeIcons],
        iconPickerShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Pick an icon',
            style: NormalHeaderTextStyle(color: Colors.black).textStyle,
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
        selectedIcon = Icon(icon.data, color: selectedColor, size: 35.0,);
      });
      debugPrint('Picked Icon: $icon');
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
        "Add Debts Account",
        style: BoldHeaderTextStyle(color: AppColors.offWhite).textStyle,
      ),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                  AccountTextField(hint: "Car payment, mortgage, small loan...", textEditingController: accountNameController),
                  const SizedBox(height: 15.0),
          
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Description",
                      style: BoldBodyTextStyle(color: Colors.black).textStyle,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  AccountTextField(hint: "Short note", textEditingController: descriptionController),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 140.0,
                          child: RadioMenuButton(
                            value: "I am owed",
                            groupValue: selectedType,
                            onChanged: (selectedValue) {
                              setState(() {
                                selectedType = selectedValue;
                              });
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all(AppColors.darkerGray),
                            ),
                            child: Text(
                              'I am owed',
                              style: BoldBodyTextStyle(color: Colors.black).textStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: RadioMenuButton(
                            value: "I owe",
                            groupValue: selectedType,
                            onChanged: (selectedValue) {
                              setState(() {
                                selectedType = selectedValue;
                              });
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all(AppColors.darkerGray),
                            ),
                            child: Text(
                              'I owe',
                              style: BoldBodyTextStyle(color: Colors.black).textStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Choose Icon", style: BoldBodyTextStyle(color: Colors.black).textStyle, textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text("Icon Color", style: BoldBodyTextStyle(color: Colors.black).textStyle, textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: openIconPicker,
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: AppColors.darkerGray,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
                              border: Border(
                                right: BorderSide(
                                  color: AppColors.textGray,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: selectedIcon ?? const Icon(Ionicons.card),
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
                              borderRadius: BorderRadius.only(topRight: Radius.circular(18), bottomRight: Radius.circular(18)),
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.textGray,
                                  width: 1.2,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Icon(FontAwesomeIcons.droplet, size: 33, color: selectedColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Initial amount: ",
                          style: BoldBodyTextStyle(color: Colors.black).textStyle, textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Goal: ",
                          style: BoldBodyTextStyle(color: Colors.black).textStyle, textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: initialPaidOffAmountController,
                          textAlign: TextAlign.center,
                          style: MoneyBodyTextStyle(color: Colors.black, fontSize: 22).textStyle,
                          decoration: InputDecoration(
                            fillColor: AppColors.darkerGray,
                            hintText: "0,00",
                            hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 22).textStyle,
                            filled: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide(width: 1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: debtGoalAmountController,
                          textAlign: TextAlign.center,
                          style: MoneyBodyTextStyle(color: Colors.black, fontSize: 22).textStyle,
                          decoration: InputDecoration(
                            fillColor: AppColors.darkerGray,
                            hintText: "0,00",
                            hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 22).textStyle,
                            filled: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide(width: 1),
                            ),
                          ),
                          keyboardType:
                    TextInputType.numberWithOptions(decimal: true, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+(\.\d{0,2})?$')),
                ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  RoundedActionButton(
                    function: () {
                      final accountData = {
                        'accountName': accountNameController.text,
                        'description': descriptionController.text,
                        'initialPaidOffAmount': double.tryParse(initialPaidOffAmountController.text) ?? 0.0,
                        'debtGoalAmount': double.tryParse(debtGoalAmountController.text) ?? 0.0,
                        'selectedIcon': selectedIcon!.icon?.codePoint,
                        'selectedIconFamily' : selectedIcon!.icon?.fontFamily,
                        // ignore: deprecated_member_use
                        'selectedColor': selectedColor.value,
                        'selectedType' : selectedType ?? 'I owe'
                      };
          
                      Navigator.pop(context, accountData);
                    },
                    label: 'Add',
                  ),
                ],
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: AppColors.offWhite,
            )
        ],
      ),
    ),
  );
}


}
  