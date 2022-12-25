import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DefaultButton extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;
  final String text;
  final double? fontSize;
  final double? height;
  final Future<void> Function() onPressed;
  final double? elevation;
  final Color borderColor;

  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.buttonColor = AgriClaimColors.tertiaryColor,
    this.textColor = Colors.white,
    this.fontSize,
    this.height,
    this.elevation,
    this.borderColor = AgriClaimColors.tertiaryColor,
  }) : super(key: key);

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 6.5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor,
          side: BorderSide(
            width: 1.0,
            color: widget.borderColor,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          elevation: widget.elevation ?? 1,
        ),
        onPressed: !isLoading ? handleOnPressed : null,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize ?? 2.5.h,
                ),
              ),
      ),
    );
  }

  Future<void> handleOnPressed() async {
    final onPressed = widget.onPressed;
    setState(() => isLoading = true);
    try {
      await onPressed();
    } catch (e) {
      rethrow;
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
}
