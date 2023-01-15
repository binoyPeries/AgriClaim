import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SnackBar infoSnackBar(
    {String? msg, Color? color, IconData? icon, Duration? time}) {
  return SnackBar(
    duration: time ?? const Duration(seconds: 5),
    content: SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.error,
            color: Colors.white,
            size: 3.h,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              msg ?? "ERROR",
              style: TextStyle(fontSize: 2.h),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: color ?? Colors.red,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
  );
}
