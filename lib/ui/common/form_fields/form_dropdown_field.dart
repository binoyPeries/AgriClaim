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
  final List<FormFieldValidator<String>> validators;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<String> items;
  const FormTextField({
    Key? key,
    required this.fieldName,
    required this.label,
    this.hintText,
    this.validators = const [],
    this.required = true,
    this.obscureText = false,
    this.keyboardType,
    required this.items,
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
              color: AgriClaimColors.secondaryColor,
              fontSize: 2.2.h,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 1.2.h),
        FormBuilderDropdown(
          name: fieldName,
          decoration: InputDecoration(
            hintText: hintText ?? "Enter $label",
            hintStyle: TextStyle(
              fontSize: 2.h,
            ),
          ),
          validator: FormBuilderValidators.compose([
            if (required)
              FormBuilderValidators.required(
                  errorText: "The $label is required"),
            ...validators,
          ]),
          items: items
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
        )
      ],
    );
  }
}
