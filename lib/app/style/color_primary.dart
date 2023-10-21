import 'package:flutter/material.dart';

class Styles {
  static ButtonStyle buttonStyle({Color? color}) {
    return ElevatedButton.styleFrom(backgroundColor: Color(0xffc77d08));
  }

  static Color colorPrimary({Color? color}) {
    return Color(0xffc77d08);
  }

  static Color colorSecondary({Color? color}) {
    return Color.fromARGB(255, 85, 64, 31);
  }
}
