import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AddCategoryButton  extends StatelessWidget{
  VoidCallback function;
  AddCategoryButton({required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: DottedBorder(
        color: Colors.black38,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [12, 8],
        strokeWidth: 1,
        child: const SizedBox(
          width: double.infinity,
          height: 56.0,
          child: Icon(Ionicons.add, size: 30, color: Colors.black38),
        ),
      ),
    );
  }
}