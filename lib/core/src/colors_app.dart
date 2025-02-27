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
}