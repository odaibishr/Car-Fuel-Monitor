import 'package:flutter/material.dart';

class FontStyles {
  static const String fontFamily = 'Cairo';

  static const TextStyle titleWhite = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
    color: Colors.white,
  );

  static const TextStyle titleBlack = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
    color: Colors.white,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
}
