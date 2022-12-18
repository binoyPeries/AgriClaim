import 'package:agriclaim/providers/user_provider.dart';
import 'package:agriclaim/routes.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/submission_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_area_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/common/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';

class FarmerSignupPage extends ConsumerWidget {
  const FarmerSignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return SafeArea(
      child: DefaultScaffold(
        appBar: const DefaultAppBar(
            title: "Farmer Details", backButtonVisible: true),
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
                  fieldName: "homeAddress",
                  label: "Home Address",
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 4,
                ),
                SizedBox(height: 4.h),
                SubmissionButton(
                  text: S.of(context).register,
                  onSubmit: () => submitRegister(formKey, context, ref),
                  afterSubmit: (context) {
                    context.push(AgriClaimRoutes.farmerHome);
                  },
                ),
              ],
            ),
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
    await userRepository.addFarmer(data);
    return true;
  }
}
