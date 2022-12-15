import 'package:agriclaim/generated/l10n.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

class CommonSignUpPage extends StatelessWidget {
  const CommonSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return SafeArea(
      child: DefaultScaffold(
        appBar: DefaultAppBar(title: "Sign Up", backButtonVisible: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 2.h),
                      FormTextField(
                        fieldName: "mobileNo",
                        label: S.of(context).mobile_no,
                        keyboardType: TextInputType.number,
                        validators: [
                          FormBuilderValidators.equalLength(10,
                              errorText:
                                  "The mobile number must only contain 10 digits")
                        ],
                      ),
                      SizedBox(height: 2.h),
                      FormTextField(
                        fieldName: "password",
                        label: S.of(context).password,
                        obscureText: true,
                      ),
                      SizedBox(height: 2.h),
                      FormTextField(
                        fieldName: "confirm_password",
                        label: S.of(context).confirm_password,
                        hintText: S.of(context).confirm_password,
                        obscureText: true,
                      ),
                      SizedBox(height: 8.h),
                      PrimaryButton(
                          onPressed: () => submitSignUp(formKey),
                          text: "Sign Up")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool submitSignUp(GlobalKey<FormBuilderState> formKey) {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) {
      return false;
    }
    //:TODO signup logic
    return true;
  }
}