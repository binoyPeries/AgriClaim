import 'package:flutter/material.dart';

abstract class AgriClaimColors {
  static const Color primaryColor = Color(0xFF00972C);
  static const Color secondaryColor = Color(0xFF1AC95A);
  static const Color tertiaryColor = Color(0xFF005A97);
  static const Color hintColor = Color(0xFFADAEB7);

  static MaterialColor primaryMaterialColor =
      MaterialColor(primaryColor.value, const {
    50: Color.fromRGBO(0, 151, 44, .1),
    100: Color.fromRGBO(0, 151, 44, .2),
    200: Color.fromRGBO(0, 151, 44, .3),
    300: Color.fromRGBO(0, 151, 44, .4),
    400: Color.fromRGBO(0, 151, 44, .5),
    500: Color.fromRGBO(0, 151, 44, .6),
    600: Color.fromRGBO(0, 151, 44, .7),
    700: Color.fromRGBO(0, 151, 44, .8),
    800: Color.fromRGBO(0, 151, 44, .9),
    900: Color.fromRGBO(0, 151, 44, 1),
  });
}
