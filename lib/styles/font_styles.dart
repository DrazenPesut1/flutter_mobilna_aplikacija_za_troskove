import 'package:flutter/material.dart';

class NormalBodyTextStyle {
  // Predefined values for font weight, size, and family
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;  
  
  // Constructor that allows customization of color only
  NormalBodyTextStyle({
    required this.color,               // Only color is passed in
    this.fontSize = 16.0,              // Default font size
    this.fontWeight = FontWeight.normal,  // Default font weight
    this.fontFamily = 'Poppins',        // Default font family                // Default line height
  });

  // Method to return the TextStyle
  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,                    // Color passed through constructor
    );
  }
}

class BoldBodyTextStyle {
  // Predefined values for font weight, size, and family
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;  
  
  // Constructor that allows customization of color only
  BoldBodyTextStyle({
    required this.color,               // Only color is passed in
    this.fontSize = 16.0,              // Default font size
    this.fontWeight = FontWeight.bold,  // Default font weight
    this.fontFamily = 'Poppins',        // Default font family                // Default line height
  });

  // Method to return the TextStyle
  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,                    // Color passed through constructor
    );
  }
}

class NormalHeaderTextStyle {
  // Predefined values for font weight, size, and family
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;  
  
  // Constructor that allows customization of color only
  NormalHeaderTextStyle({
    required this.color,               // Only color is passed in
    this.fontSize = 21.0,              // Default font size
    this.fontWeight = FontWeight.normal,  // Default font weight
    this.fontFamily = 'Poppins',        // Default font family                // Default line height
  });

  // Method to return the TextStyle
  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,                    // Color passed through constructor
    );
  }
}

class BoldHeaderTextStyle {
  // Predefined values for font weight, size, and family
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;  
  
  // Constructor that allows customization of color only
  BoldHeaderTextStyle({
    required this.color,               // Only color is passed in
    this.fontSize = 21.0,              // Default font size
    this.fontWeight = FontWeight.bold,  // Default font weight
    this.fontFamily = 'Poppins',        // Default font family                // Default line height
  });

  // Method to return the TextStyle
  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,                    // Color passed through constructor
    );
  }
}

class MoneyBodyTextStyle{
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;  
  
  // Constructor that allows customization of color only
  MoneyBodyTextStyle({
    required this.color,               // Only color is passed in
    this.fontSize = 19.0,              // Default font size
    this.fontWeight = FontWeight.bold,  // Default font weight
    this.fontFamily = 'Poppins',        // Default font family                // Default line height
  });

  // Method to return the TextStyle
  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,                    // Color passed through constructor
    );
  }
}
