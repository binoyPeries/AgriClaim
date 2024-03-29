import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

class FormTextField extends StatelessWidget {
  final String fieldName;
  final String label;
  final String? hintText;
  final bool required;
  final bool readOnly;
  final List<FormFieldValidator<String>> validators;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double? labelFontSize;
  final double? textFontSize;
  final String? initialValue;
  final FontWeight? labelFontWeight;
  final Color? labelFontColor;
  const FormTextField({
    Key? key,
    required this.fieldName,
    required this.label,
    this.labelFontColor,
    this.hintText,
    this.readOnly = false,
    this.validators = const [],
    this.required = true,
    this.obscureText = false,
    this.keyboardType,
    this.labelFontWeight,
    this.labelFontSize,
    this.textFontSize,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 1.5.h),
        Text(
          label,
          style: TextStyle(
              color: labelFontColor ?? AgriClaimColors.secondaryColor,
              fontSize: labelFontSize ?? 2.2.h,
              fontWeight: labelFontWeight ?? FontWeight.w500),
        ),
        SizedBox(height: 1.2.h),
        FormBuilderTextField(
          readOnly: readOnly,
          name: fieldName,
          initialValue: initialValue,
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText ?? label,
            hintStyle: TextStyle(
              fontSize: textFontSize ?? 2.h,
            ),
          ),
          validator: FormBuilderValidators.compose([
            if (required)
              FormBuilderValidators.required(
                  errorText: "The $label is required"),
            ...validators,
          ]),
          style: TextStyle(fontSize: textFontSize ?? 2.h),
        )
      ],
    );
  }
}
