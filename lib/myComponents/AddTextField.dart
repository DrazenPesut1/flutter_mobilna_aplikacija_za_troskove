import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget{
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController textEditingController;
  const AddTextField({required this.label,required this.icon,required this.isPassword, required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14.0, fontFamily: 'Poppins', color: Colors.black),
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.4)),
      )
    );
  }
}