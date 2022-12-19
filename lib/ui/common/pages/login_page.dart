import 'package:agriclaim/generated/l10n.dart';
import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/routes.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/assets.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../components/submission_button.dart';

class LoginPage extends ConsumerWidget {
  final UserRoles userType;
  const LoginPage({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return DefaultScaffold(
      appBar:
          DefaultAppBar(title: S.of(context).login, backButtonVisible: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5.h),
              SvgPicture.asset(AgriClaimAssets.agriClaimLogo128),
              Center(
                child: Text(
                  "AgriClaim",
                  style: TextStyle(
                      fontSize: 5.h,
                      fontWeight: FontWeight.w800,
                      color: AgriClaimColors.primaryColor),
                ),
              ),
              SizedBox(height: 9.h),
              FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                    SizedBox(height: 5.h),
                    SubmissionButton(
                      text: S.of(context).login,
                      onSubmit: () => submitLogin(formKey, ref),
                      afterSubmit: (context) => userType == UserRoles.farmer
                          ? context.push(AgriClaimRoutes.farmerHome)
                          : context.push(AgriClaimRoutes.officerHome),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 2.h,
                              color: AgriClaimColors.primaryColor),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => context
                              .push(AgriClaimRoutes.userSignUpPath(userType)),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 2.2.h,
                                fontWeight: FontWeight.w800,
                                color: AgriClaimColors.tertiaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> submitLogin(
      GlobalKey<FormBuilderState> formKey, WidgetRef ref) async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    final authRepository = ref.read(authRepositoryProvider);
    if (!isValid) {
      return false;
    }
    String phoneNumber = formKey.currentState?.value["mobileNo"];
    String password = formKey.currentState?.value["password"];
    await authRepository.signInWithPhoneAndPassword(phoneNumber, password);
    return true;
  }
}
