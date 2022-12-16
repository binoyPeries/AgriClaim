import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_area_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/common/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

class FarmerSignupPage extends StatelessWidget {
  const FarmerSignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return SafeArea(
      child: DefaultScaffold(
        appBar: const DefaultAppBar(
            title: "Farmer Sign Up", backButtonVisible: true),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 3.h),
                FormTextField(
                  fieldName: "firstName",
                  label: "First Name",
                  validators: [
                    (value) {
                      if (!lettersOnly(value!)) {
                        return "First name can only contain letters characters";
                      }
                      return null;
                    }
                  ],
                ),
                SizedBox(height: 2.h),
                FormTextField(
                  fieldName: "lastName",
                  label: "Last Name",
                  validators: [
                    (value) {
                      if (!lettersOnly(value!)) {
                        return "Last name can only contain letters characters";
                      }
                      return null;
                    }
                  ],
                ),
                SizedBox(height: 2.h),
                const FormTextField(
                  fieldName: "nic",
                  label: "NIC",
                ),
                SizedBox(height: 2.h),
                const FormTextAreaField(
                  fieldName: "address",
                  label: "Home Address",
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 4,
                ),
                SizedBox(height: 4.h),
                PrimaryButton(
                    onPressed: () => submitRegister(formKey), text: "Register"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool submitRegister(GlobalKey<FormBuilderState> formKey) {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) {
      return false;
    }
    //:TODO login logic
    return true;
  }
}
