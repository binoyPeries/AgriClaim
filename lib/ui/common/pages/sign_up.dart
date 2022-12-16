import 'package:agriclaim/generated/l10n.dart';
import 'package:agriclaim/routes.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class CommonSignUpPage extends StatelessWidget {
  final UserRoles userType;

  const CommonSignUpPage({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    TextEditingController otpCode = TextEditingController();
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
                      PrimaryButton(
                          onPressed: () =>
                              submitSignUp(formKey, context, userType),
                          text: "Sign Up"),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: otpCode,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Enter Otp",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 15, left: 15),
                            child: Text("Something"),
                          ),
                        ),
                      ),
                      PrimaryButton(
                        onPressed: () async {
                          // await phoneSignIn(
                          //     phoneNumber:
                          //         formKey.currentState?.fields['mobileNo']);
                        },
                        text: '',
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

  bool submitSignUp(GlobalKey<FormBuilderState> formKey, BuildContext context,
      UserRoles userType) {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) {
      return false;
    }
    //:TODO signup logic
    print(formKey.currentState?.value["mobileNo"]);
    userType == UserRoles.farmer
        ? context.push(AgriClaimRoutes.farmerSignUp)
        : context.push(AgriClaimRoutes.officerSignUp);

    return true;
  }
}
