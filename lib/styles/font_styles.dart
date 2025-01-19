import 'package:flutter/material.dart';

class NormalBodyTextStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;

  NormalBodyTextStyle({
    required this.color,
    this.fontSize = 15.0,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Montserrat',
  });

  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
    );
  }
}

class BoldBodyTextStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;

  BoldBodyTextStyle({
    required this.color,
    this.fontSize = 15.0,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'Montserrat',
  });

  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
    );
  }
}

class NormalHeaderTextStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;

  NormalHeaderTextStyle({
    required this.color,
    this.fontSize = 21.0,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Montserrat',
  });

  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
    );
  }
}

class BoldHeaderTextStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;

  BoldHeaderTextStyle({
    required this.color,
    this.fontSize = 21.0,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'Montserrat',
  });

  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
    );
  }
}

class MoneyBodyTextStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;

  MoneyBodyTextStyle({
    required this.color,
    required this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'Poppins',
  });

  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
    );
  }
}

class NormalVariableFontTextStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;

  NormalVariableFontTextStyle({
    required this.color,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Montserrat',
  });

  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
    );
  }
}

class BoldVariableFontTextStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;

  BoldVariableFontTextStyle({
    required this.color,
    required this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'Montserrat',
  });

  TextStyle get textStyle {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
    );
  }
}
