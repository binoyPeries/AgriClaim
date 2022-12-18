import 'package:agriclaim/ui/common/utils/display_lat_long.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/farm_provider.dart';

class FormLocationAdditionField extends ConsumerWidget {
  final String fieldName;
  final String label;
  final int index;
  final String? hintText;
  final bool notRemovable;
  final Function onPressed;
  final List<FormFieldValidator<String>> validators;
  const FormLocationAdditionField({
    Key? key,
    required this.fieldName,
    required this.label,
    this.hintText,
    required this.index,
    this.validators = const [],
    this.notRemovable = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsList = ref.watch(farmLocationCountStateProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Location ${index + 1}",
          style: TextStyle(
              color: AgriClaimColors.secondaryColor,
              fontSize: 2.2.h,
              fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              convertMapToLatLong(locationsList.elementAt(index)),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: AgriClaimColors.tertiaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: GestureDetector(
                  onTap: () => onPressed(),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    child: const Icon(
                      Icons.add_location_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
