import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final String label;
  final IconData icon;
  final bool isPassword;
  const MyTextField(this.label, this.icon, this.isPassword, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 15.0),
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