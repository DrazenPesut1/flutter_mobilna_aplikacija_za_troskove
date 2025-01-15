import 'package:expense_tracker/myComponents/AddTextField.dart';
import 'package:expense_tracker/myComponents/HomeComponents/RoundedCreateButton.dart';
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
  Color selectedColor = Colors.deepOrange;
  Icon? selectedIcon = Icon(Ionicons.gift, size: 32, color: Colors.deepOrange,);


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
                      size: 32.0,
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
          size: 32.0,
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
            const SizedBox(
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        height: 55,
                        decoration: const BoxDecoration(
                          color: Color(0x2A000000),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)
                          ),
                          border: Border(
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.2
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Icon", style: BoldBodyTextStyle(color: Colors.black).textStyle,),
                              Icon(Ionicons.gift, size: 32, color: selectedColor)
                          ],),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: openColorPicker,
                        child: Container(
                          height: 55,
                          decoration: const BoxDecoration(
                            color: Color(0x2A000000),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                            ),
                            border: Border(
                              left: BorderSide(
                                color: Colors.black,
                                width: 1.2
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Color", style: BoldBodyTextStyle(color: Colors.black).textStyle,),
                                Icon(Ionicons.color_fill, size: 32, color: selectedColor,)
                            ],),
                          ),
                        ),
                      ),
                    )
                  ],),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundedCreateButton(function: (){
                  final categoryData = ({
                    'categoryName' : categoryNameController.text,
                    'selectedIcon' : selectedIcon?.icon ?? Icons.abc,
                    'selectedColor' : selectedColor
                  });

                  Navigator.pop(context, categoryData);
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}