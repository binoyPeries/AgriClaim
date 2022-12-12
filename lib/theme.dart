import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';

class AgriClaimTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: AgriClaimColors.primaryMaterialColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AgriClaimColors.primaryColor,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AgriClaimColors.tertiaryColor,
            width: 0.5,
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: AgriClaimColors.hintColor,
        ),
      ),
    );
  }
}
