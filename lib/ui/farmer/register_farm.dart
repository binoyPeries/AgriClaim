import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

import '../common/form_fields/form_text_area_field.dart';

class RegisterFarmPage extends StatelessWidget {
  const RegisterFarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return SafeArea(
      child: DefaultScaffold(
        appBar: const DefaultAppBar(
            title: "Register Farm", backButtonVisible: true),
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
                        fieldName: "farmName",
                        label: "Farm Name (ex: Farm 1)",
                        keyboardType: TextInputType.text,
                        validators: [FormBuilderValidators.min(1)],
                      ),
                      SizedBox(height: 2.h),
                      FormTextAreaField(
                        fieldName: "farmAddress",
                        label: "Farm Address",
                        maxLines: 3,
                        validators: [FormBuilderValidators.min(1)],
                      ),
                      SizedBox(height: 2.h),
                      FormTextField(
                        fieldName: "lastName",
                        label: "Last Name",
                        validators: [FormBuilderValidators.min(1)],
                      ),
                      SizedBox(height: 8.h),
                      PrimaryButton(
                          onPressed: () => registerFarm(formKey),
                          text: "Register Farm")
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

  bool registerFarm(GlobalKey<FormBuilderState> formKey) {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) {
      return false;
    }
    //:TODO register farm logic
    return true;
  }
}
