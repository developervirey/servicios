import 'package:flutter/material.dart';
import 'package:servicios/core/src/colors_app.dart';
class TextStylesApp {
  static  TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: ColorsApp.blueText,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
  );
}