import 'package:flutter/material.dart';

class MyColorBox extends StatelessWidget{
  final Color color_;

  const MyColorBox({required this.color_,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 37.5,
        width: 37.5,
        decoration: BoxDecoration(
        color: color_, // Dynamically show selected color
        border: Border.all(color: color_),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}