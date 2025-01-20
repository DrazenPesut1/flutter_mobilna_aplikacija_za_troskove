import 'package:expense_tracker/myComponents/AccountTextField.dart';
import 'package:expense_tracker/myComponents/HomeComponents/RoundedActionButton.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPage();
}

class _AddCategoryPage extends State<AddCategoryPage> {
  Color selectedColor = Colors.deepOrange;
  Icon? selectedIcon = Icon(FontAwesomeIcons.tv, size: 33, color: Colors.deepOrange,);
  final List<String> options = ['Expense', 'Income'];
  String selectedValue = 'Expense';

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
                  if (selectedIcon != null) {
                    selectedIcon = Icon(
                      selectedIcon!.icon,
                      color: selectedColor,
                      size: 33.0,
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
        iconPackModes: [IconPack.allMaterial, IconPack.fontAwesomeIcons],
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
          size: 33.0,
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Ionicons.chevron_back),
            iconSize: 30.0,
            ),
          backgroundColor: AppColors.offWhite,
          foregroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          title: Text("New Category", style: BoldHeaderTextStyle(color: AppColors.primary).textStyle,),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
              height: 50,
              width: double.infinity,
              child: SegmentedButton<String>(
                segments: options.map((option) {
                  return ButtonSegment(
                    value: option,
                    label: Text(option),
                  );
                }).toList(),
                selected: <String>{selectedValue},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    selectedValue = newSelection.first; 
                  });
                },
                showSelectedIcon: false,
                style: ButtonStyle(
                  side: WidgetStateProperty.all(BorderSide.none),
                  animationDuration: Duration(milliseconds: 200),
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.primary; 
                    }
                    return AppColors.darkerGray; 
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.offWhite; 
                    }
                    return AppColors.textGray; 
                  }),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Text("Category name", style: BoldBodyTextStyle(color: Colors.black).textStyle,),
            const SizedBox(height: 5.0,),
            AccountTextField(hint: "Category name", textEditingController: categoryNameController),
            const SizedBox(height: 15.0,),
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
            const SizedBox(height: 5),
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
                            width: 0.8,
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
                        borderRadius: BorderRadius.only(topRight: Radius.circular(18), bottomRight: Radius.circular(18)),
                        border: Border(
                          left: BorderSide(
                            color: AppColors.textGray,
                            width: 0.8,
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
                const SizedBox(
                  height: 15,
                ),
                RoundedActionButton(label: "Create",function: () {
                  final categoryData = ({
                    'categoryName' : categoryNameController.text,
                    'categoryIcon': selectedIcon!.icon?.codePoint ?? Ionicons.gift.codePoint,
                    // ignore: deprecated_member_use
                    'categoryColor' : selectedColor.value,
                    'categoryType' : selectedValue,
                    'categoryExpense' : 0.0
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
