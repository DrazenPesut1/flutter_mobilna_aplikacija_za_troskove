import 'package:expense_tracker/myComponents/AddTextField.dart';
import 'package:expense_tracker/myComponents/MyColorBox.dart';
import 'package:expense_tracker/myComponents/MyTextField.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_regular_account_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyCard.dart';
import 'package:expense_tracker/myComponents/MyAddAccountButton.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPage();
}

class _AddCategoryPage extends State<AddCategoryPage> {
  late Color selectedColor = Colors.blue;
  late Icon selectedIcon = Icon(Icons.dangerous);

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


  final TextEditingController categoryNameController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        automaticallyImplyLeading: false,
        title: Text("New Expense Category", style: BoldHeaderTextStyle(color: Colors.black).textStyle,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text("Category Name", style: BoldBodyTextStyle(color: Colors.black).textStyle,),
                ),
                const SizedBox(
                  height: 10,
                ),
                AddTextField(label: "Enter category name", icon: Icons.category_rounded, isPassword: false, textEditingController: categoryNameController),
                const SizedBox(
                  height: 30,
                ),
                Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Icon Selector
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
              child: selectedIcon ?? const Icon(Icons.credit_card_rounded),
            ),
          ),
        ),
      ],
    ),
    // Spacer
    const SizedBox(height: 25.0),
    // Color Selector
    Column(
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
            child: Center(
              child: MyColorBox(color_: selectedColor),
            ),
          ),
        ),
      ],
    ),
  ],
)
              ],
            )
          ],
        ),
      ),
    );
  }
}