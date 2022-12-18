import 'package:agriclaim/providers/farm_provider.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

import '../common/form_fields/form_text_area_field.dart';
import '../common/form_fields/location_addition_text_box.dart';

class RegisterFarmPage extends ConsumerWidget {
  const RegisterFarmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      FormLocationAdditionField(
                        fieldName: '',
                        hintText: 'Location 1',
                        label: '',
                        onPressed: () {},
                      ),
                      FormLocationAdditionField(
                        fieldName: '',
                        hintText: 'Location 2',
                        label: '',
                        onPressed: () {},
                      ),
                      FormLocationAdditionField(
                        fieldName: '',
                        hintText: 'Location 3',
                        label: '',
                        onPressed: () {},
                      ),
                      FormLocationAdditionField(
                        fieldName: '',
                        hintText: 'Location 4',
                        label: '',
                        onPressed: () {},
                      ),
                      FarmLocationsWidget(),
                      SizedBox(height: 3.h),
                      PrimaryButton(
                          onPressed: () => registerFarm(formKey, context, ref),
                          text: "Register Farm"),
                      SizedBox(height: 3.h),
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

  bool registerFarm(GlobalKey<FormBuilderState> formKey, BuildContext context,
      WidgetRef ref) {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    final farmRepository = ref.read(farmRepositoryProvider);

    if (!isValid) {
      return false;
    }

    final data = formKey.currentState?.value ?? {};
    print("data");
    print(data);
    return true;
  }
}

class FarmLocationsWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsList = ref.watch(farmLocationCountStateProvider);

    return Column(
      children: [
        ListView.builder(
          itemCount: locationsList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return FormLocationAdditionField(
                fieldName: '',
                hintText: "Location ${index + 5}",
                label: "",
                notRemovable: false,
                onPressed: () {});
          },
        ),
        SizedBox(height: 3.h),
        PrimaryButton(
            onPressed: () {
              print(locationsList.length);
              ref
                  .read(farmLocationCountStateProvider.notifier)
                  .addLocation({'x': 0, 'y': 0});
            },
            buttonColor: Colors.white,
            textColor: AgriClaimColors.primaryColor,
            borderColor: AgriClaimColors.primaryColor,
            text: "Add Another Location"),
        SizedBox(height: 3.h),
      ],
    );
  }
}
