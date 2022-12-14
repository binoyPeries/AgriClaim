import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String text;
  final double fontSize;
  final double height;
  final Function onPressed;
  final double? elevation;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.buttonColor = AgriClaimColors.tertiaryColor,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.height = 45,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const StadiumBorder(),
          elevation: elevation ?? 1,
        ),
        onPressed: () => onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
