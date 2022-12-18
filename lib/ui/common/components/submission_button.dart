import 'package:agriclaim/ui/common/components/default_button.dart';
import 'package:agriclaim/ui/common/components/info_snack_bar.dart';
import 'package:agriclaim/ui/common/utils/agriclaim_exception.dart';
import 'package:flutter/material.dart';

class SubmissionButton extends StatefulWidget {
  final String text;
  final Future<bool> Function() onSubmit;
  final ValueChanged<BuildContext> afterSubmit;

  const SubmissionButton(
      {Key? key,
      required this.text,
      required this.onSubmit,
      required this.afterSubmit})
      : super(key: key);

  @override
  State<SubmissionButton> createState() => _SubmissionButtonState();
}

class _SubmissionButtonState extends State<SubmissionButton> {
  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: widget.text,
      onPressed: () async {
        try {
          final isSuccessful = await widget.onSubmit();
          if (!isSuccessful) return;
          if (mounted) {
            widget.afterSubmit(context);
          }
        } on AgriclaimException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(infoSnackBar(msg: e.errorMsg));
        }
      },
    );
  }
}