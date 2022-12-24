import 'package:agriclaim/models/farmer.dart';
import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/providers/user_provider.dart';
import 'package:agriclaim/repository/auth_repository.dart';
import 'package:agriclaim/ui/common/components/submission_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_area_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/farmer/claim_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    final farmer = ref.watch(farmerDetailsProvider);
    final authRepository = ref.read(authRepositoryProvider);
    final labelTextSize = 2.3.h;
    final valueTextSize = 2.3.h;

    return farmer.when(
      data: (data) {
        return SingleChildScrollView(
            child: data != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      const SectionDivider(sectionName: "Personal Details"),
                      SizedBox(height: 3.h),
                      FormTextField(
                        initialValue: data.farmerId,
                        fieldName: "accID",
                        label: "Account ID",
                        readOnly: true,
                        labelFontSize: labelTextSize,
                        textFontSize: valueTextSize,
                      ),
                      SizedBox(height: 2.h),
                      FormTextField(
                        initialValue: data.phoneNumber,
                        fieldName: "mobile",
                        label: "Mobile Number",
                        readOnly: true,
                        labelFontSize: labelTextSize,
                        textFontSize: valueTextSize,
                      ),
                      ProfileEditableForm(
                        formKey: formKey,
                        labelTextSize: labelTextSize,
                        valueTextSize: valueTextSize,
                        data: data,
                      ),
                      SizedBox(height: 1.5.h),
                      SubmissionButton(
                        text: "Logout",
                        onSubmit: () => logout(authRepository),
                        afterSubmit: (context) {},
                        buttonColor: Colors.white,
                        textColor: AgriClaimColors.tertiaryColor,
                      ),
                    ],
                  )
                : const Center(
                    child: Text("Couldn't load profile Information"),
                  ));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text(e.toString())),
    );
  }

  Future<bool> logout(AuthRepository authRepository) async {
    try {
      await authRepository.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ProfileEditableForm extends ConsumerWidget {
  final Farmer data;
  final GlobalKey<FormBuilderState> formKey;
  final double labelTextSize;
  final double valueTextSize;
  const ProfileEditableForm({
    Key? key,
    required this.formKey,
    required this.labelTextSize,
    required this.valueTextSize,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.firstName,
            fieldName: "firstName",
            label: "First Name",
            readOnly: true,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.lastName,
            fieldName: "lastName",
            label: "Last Name",
            readOnly: true,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.nic,
            fieldName: "nic",
            label: "NIC",
            readOnly: true,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 2.h),
          FormTextAreaField(
            label: "Home Address",
            initialValue: data.homeAddress,
            fieldName: 'homeAddress',
            readOnly: true,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 3.h),
          const SectionDivider(sectionName: "Bank Details"),
          SizedBox(height: 3.h),
          FormTextField(
            initialValue: data.accNumber,
            fieldName: "accountNumber",
            label: "Account Number",
            readOnly: true,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.accHolderName,
            fieldName: "accountHolderName",
            label: "Account Holder's Name",
            readOnly: true,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.bank,
            fieldName: "bank",
            label: "Bank",
            readOnly: true,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.bankBranch,
            fieldName: "bankBranch",
            label: "Branch",
            readOnly: true,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 7.h),
          SubmissionButton(
            text: "Edit Profile",
            onSubmit: () => updateProfile(),
            afterSubmit: (context) {},
          ),
        ],
      ),
    );
  }

  Future<bool> updateProfile() async {
    try {
      // await authRepository.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}

// PrimaryButton(
// text: "Logout",
// onPressed: () async {
// await authRepository.signOut();
// }),
