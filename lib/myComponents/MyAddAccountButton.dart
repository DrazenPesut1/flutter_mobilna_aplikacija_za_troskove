import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MyAddAccountButton extends StatefulWidget {
  final String account_type;
  const MyAddAccountButton({required this.account_type, super.key});

  @override
  _MyAddAccountButtonState createState() => _MyAddAccountButtonState();
}

class _MyAddAccountButtonState extends State<MyAddAccountButton> {
  Color _iconColor = Colors.green; // Default color for the icon

  // Function to handle the color picker dialog
  void _pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _iconColor, // Initial color
              onColorChanged: (color) {
                setState(() {
                  _iconColor = color; // Update the icon color dynamically
                });
              },
              showLabel: false, // Optional: Hide the color code label
              pickerAreaHeightPercent: 0.8, // Control the picker area height
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the color picker dialog
              },
              child: Text('Close', style: BoldBodyTextStyle(color: AppColors.primary).textStyle,),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      height: 45.0,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel", style: BoldBodyTextStyle(color: AppColors.primary).textStyle),
                          ),
                  TextButton(
                            onPressed: () {
                              
                            },
                            child: Text("Add account", style: BoldBodyTextStyle(color: AppColors.primary).textStyle),
                          ),
                ],
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                backgroundColor: AppColors.offWhite,
                title: const Align(
                  alignment: Alignment.center,
                  child: Text("Regular Account"),
                ),
                titleTextStyle: BoldHeaderTextStyle(color: Colors.black).textStyle,
                content: SizedBox(
                  height: 270,
                  width: 270,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Account Name",
                          style: NormalBodyTextStyle(color: Colors.black).textStyle,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                          hintText: "Card, cash...",
                          hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 15.0),
                          filled: true,
                          fillColor: AppColors.offWhite,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primary,
                                style: BorderStyle.solid,
                                width: 1.4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primary,
                                style: BorderStyle.solid,
                                width: 1.4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose icon to display: ",
                              style: NormalBodyTextStyle(color: Colors.black).textStyle),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(width: 1.4, color: AppColors.primary),
                            ),
                            child: Icon(
                              Ionicons.card,
                              color: _iconColor, // Dynamically change icon color
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose icon color: ",
                              style: NormalBodyTextStyle(color: Colors.black).textStyle),
                          GestureDetector(
                            onTap: () => _pickColor(context), // Open color picker
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: _iconColor, // Dynamically show selected color
                                border: Border.all(color: _iconColor),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            "Initial Balance: ",
                            style: NormalBodyTextStyle(color: Colors.black).textStyle,
                          ),
                          const SizedBox(width: 15.0),
                          const Expanded(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                hintText: "0€",
                                hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 15.0),
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                                filled: true,
                                fillColor: AppColors.offWhite,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    style: BorderStyle.solid,
                                    width: 1.4,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    style: BorderStyle.solid,
                                    width: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _iconColor,
          foregroundColor: AppColors.offWhite,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          textStyle: NormalBodyTextStyle(color: Colors.black).textStyle,
        ),
        child: Text("Add ${widget.account_type} Account"),
      ),
    );
  }
}
