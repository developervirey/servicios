import 'package:flutter/material.dart';

class ColorsApp{
  static Gradient backgroundSplash = const LinearGradient(
    colors: [
      Color.fromRGBO(3, 27, 52, 1.0),
      Color.fromRGBO(6, 41, 79, 1.0),
    ],
    begin: Alignment.centerLeft, // Punto de inicio del degradado
    end: Alignment.centerRight, // Punto de finalización del degradado
  );

  static const Color _blueColor = Color.fromRGBO(4, 28, 54, 1.0);
  static const blueText = _blueColor;
  static const blueIcon = _blueColor;

  // colors for the dialog
  static const Color buttonText = Color.fromRGBO(255, 255, 255, 1);
  static const Color buttonBackground = Color.fromRGBO(31, 89, 151, 1);
  static const Color buttonBackgroundCancel = Color.fromRGBO(255, 0, 0, 1);
}