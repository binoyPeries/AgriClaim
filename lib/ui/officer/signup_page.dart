import 'package:agriclaim/providers/user_provider.dart';
import 'package:agriclaim/routes.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/submission_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class OfficerSignUpPage extends ConsumerWidget {
  const OfficerSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return DefaultScaffold(
      appBar: const DefaultAppBar(
          title: "Officer Details", backButtonVisible: true),
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
                      fieldName: "officerRegNo",
                      label: "Officer Registration Number",
                      keyboardType: TextInputType.text,
                      validators: [FormBuilderValidators.min(1)],
                    ),
                    SizedBox(height: 2.h),
                    FormTextField(
                      fieldName: "firstName",
                      label: "First Name",
                      validators: [FormBuilderValidators.min(1)],
                    ),
                    SizedBox(height: 2.h),
                    FormTextField(
                      fieldName: "lastName",
                      label: "Last Name",
                      validators: [FormBuilderValidators.min(1)],
                    ),
                    SizedBox(height: 2.h),
                    FormTextField(
                      fieldName: "email",
                      label: "Email Address",
                      validators: [
                        FormBuilderValidators.email(
                            errorText: "Please enter a valid email address.")
                      ],
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8.h),
                    SubmissionButton(
                      onSubmit: () => submitRegister(formKey, context, ref),
                      text: "Sign Up",
                      afterSubmit: (context) {
                        context.push(AgriClaimRoutes.officerHome);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> submitRegister(GlobalKey<FormBuilderState> formKey,
      BuildContext context, WidgetRef ref) async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    final userRepository = ref.read(userRepositoryProvider);
    if (!isValid) {
      return false;
    }
    final data = formKey.currentState?.value ?? {};

    await userRepository.addOfficer(data);
    return true;
  }
}
