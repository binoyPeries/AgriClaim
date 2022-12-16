import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

class FormLocationAdditionField extends StatelessWidget {
  final String fieldName;
  final String label;
  final String? hintText;
  final bool notRemovable;
  final Function onPressed;
  final List<FormFieldValidator<String>> validators;
  const FormLocationAdditionField({
    Key? key,
    required this.fieldName,
    required this.label,
    this.hintText,
    this.validators = const [],
    this.notRemovable = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
              color: AgriClaimColors.secondaryColor,
              fontSize: 2.2.h,
              fontWeight: FontWeight.w500),
        ),
        FormBuilderTextField(
          name: fieldName,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: AgriClaimColors.tertiaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: GestureDetector(
                  onTap: () => onPressed(),
                  child: const Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            hintText: hintText ?? "Enter $label",
            hintStyle: TextStyle(
              fontSize: 2.h,
            ),
          ),
          validator: FormBuilderValidators.compose([
            if (notRemovable)
              FormBuilderValidators.required(
                  errorText: "The $label is required"),
            ...validators,
          ]),
        )
      ],
    );
  }
}
