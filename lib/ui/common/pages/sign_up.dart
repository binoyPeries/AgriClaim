import 'package:agriclaim/generated/l10n.dart';
import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/routes.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/submission_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class CommonSignUpPage extends ConsumerWidget {
  final UserRoles userType;

  const CommonSignUpPage({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return SafeArea(
      child: DefaultScaffold(
        appBar: const DefaultAppBar(title: "Sign Up", backButtonVisible: true),
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
                      SubmissionButton(
                        text: "Sign Up",
                        onSubmit: () =>
                            submitSignUp(formKey, ref, context, userType),
                        afterSubmit: (context) {
                          userType == UserRoles.farmer
                              ? context.push(AgriClaimRoutes.farmerSignUp)
                              : context.push(AgriClaimRoutes.officerSignUp);
                        },
                      ),
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

  Future<bool> submitSignUp(GlobalKey<FormBuilderState> formKey, WidgetRef ref,
      BuildContext context, UserRoles userType) async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    final authRepository = ref.read(authRepositoryProvider);

    if (!isValid) {
      return false;
    }

    String phoneNumber = formKey.currentState?.value["mobileNo"];
    String password = formKey.currentState?.value["password"];
    await authRepository.createUserWithPhoneAndPassword(
        phoneNumber.trim(), password.trim(), userType);

    return true;
  }
}
