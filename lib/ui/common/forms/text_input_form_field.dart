import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import "package:flutter_form_builder/flutter_form_builder.dart";
import 'package:form_builder_validators/form_builder_validators.dart';

class TextInputFormField extends StatelessWidget {
  final String fieldName;
  final String label;
  final String? hintText;
  final bool required;
  final List<FormFieldValidator<String>> validators;

  const TextInputFormField({
    Key? key,
    required this.fieldName,
    required this.label,
    this.hintText,
    this.validators = const [],
    this.required = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
              color: AgriClaimColors.secondaryColor,
              fontSize: 13.0,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5.0),
        FormBuilderTextField(
          name: fieldName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText ?? "Enter $label",
            hintStyle: const TextStyle(
              fontSize: 12.0,
            ),
          ),
          validator: FormBuilderValidators.compose([
            ...validators,
            if (required)
              FormBuilderValidators.required(
                  errorText: "The $label is required"),
          ]),
        )
      ],
    );
  }
}
