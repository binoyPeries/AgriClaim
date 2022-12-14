import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/assests.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  final UserRoles userType;
  const LoginPage({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 10.h),
                FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormTextField(
                        fieldName: "mobileNo",
                        label: "Mobile Number",
                        keyboardType: TextInputType.number,
                        validators: [
                          FormBuilderValidators.equalLength(10,
                              errorText:
                                  "The mobile number must only contain 10 digits")
                        ],
                      ),
                      SizedBox(height: 2.h),
                      const FormTextField(
                        fieldName: "password",
                        label: "Password",
                        obscureText: true,
                      ),
                      SizedBox(height: 8.h),
                      PrimaryButton(
                          onPressed: () => submitLogin(formKey), text: "Login")
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

  bool submitLogin(GlobalKey<FormBuilderState> formKey) {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) {
      return false;
    }
    //:TODO login logic
    return true;
  }
}
