import 'package:agriclaim/models/farmer.dart';
import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/providers/user_provider.dart';
import 'package:agriclaim/repository/auth_repository.dart';
import 'package:agriclaim/ui/common/components/submission_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_area_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/farmer/claim_view_page.dart';
import 'package:agriclaim/utils/helper_functions.dart';
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
    final profileIsEditing = ref.watch(profileInEditModeProvider);
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
            readOnly: !profileIsEditing,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.lastName,
            fieldName: "lastName",
            label: "Last Name",
            readOnly: !profileIsEditing,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.nic,
            fieldName: "nic",
            label: "NIC",
            readOnly: !profileIsEditing,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 2.h),
          FormTextAreaField(
            label: "Home Address",
            initialValue: data.homeAddress,
            fieldName: 'homeAddress',
            readOnly: !profileIsEditing,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
          ),
          SizedBox(height: 3.h),
          const SectionDivider(sectionName: "Bank Details"),
          SizedBox(height: 3.h),
          FormTextField(
            initialValue: data.accountNumber,
            fieldName: "accountNumber",
            label: "Account Number",
            readOnly: !profileIsEditing,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
            keyboardType: TextInputType.number,
            required: false,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.accountHolderName,
            fieldName: "accountHolderName",
            label: "Account Holder's Name",
            readOnly: !profileIsEditing,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
            required: false,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.bank,
            fieldName: "bank",
            label: "Bank",
            readOnly: !profileIsEditing,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
            required: false,
          ),
          SizedBox(height: 2.h),
          FormTextField(
            initialValue: data.bankBranch,
            fieldName: "bankBranch",
            label: "Branch",
            readOnly: !profileIsEditing,
            labelFontSize: labelTextSize,
            textFontSize: valueTextSize,
            required: false,
          ),
          SizedBox(height: 7.h),
          SubmissionButton(
            text: profileIsEditing ? "Save Changes" : "Edit Profile",
            onSubmit: () =>
                profileIsEditing ? updateProfile(ref, data) : editProfile(ref),
            afterSubmit: (context) {},
          ),
        ],
      ),
    );
  }

  Future<bool> editProfile(WidgetRef ref) {
    ref.read(profileInEditModeProvider.notifier).state = true;
    return Future(() => true);
  }

  Future<bool> updateProfile(WidgetRef ref, Farmer farmer) async {
    try {
      final isValid = formKey.currentState?.saveAndValidate() ?? false;
      final userRepository = ref.read(userRepositoryProvider);
      if (!isValid) {
        return false;
      }
      final finalData = getDifferenceOfTwoMaps(
          newMap: formKey.currentState?.value ?? {}, oldMap: farmer.toJson());
      await userRepository.updateLoggedInFarmerProfile(farmer.docId, finalData);

      ref.read(profileInEditModeProvider.notifier).state = false;
      return true;
    } catch (e) {
      return false;
    }
  }
}
