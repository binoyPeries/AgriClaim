import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

import '../common/form_fields/form_text_area_field.dart';
import '../common/form_fields/location_addition_text_box.dart';

class RegisterFarmPage extends StatefulWidget {
  const RegisterFarmPage({Key? key}) : super(key: key);

  @override
  State<RegisterFarmPage> createState() => _RegisterFarmPageState();
}

class _RegisterFarmPageState extends State<RegisterFarmPage> {
  int _count = 0;

  void _addNewLocationBox() {
    setState(() {
      _count = _count + 1;
    });
  }

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
                      ListView.builder(
                        itemCount: _count,
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
                          onPressed: () => _addNewLocationBox(),
                          buttonColor: Colors.white,
                          textColor: AgriClaimColors.primaryColor,
                          borderColor: AgriClaimColors.primaryColor,
                          text: "Add Another Location"),
                      SizedBox(height: 3.h),
                      PrimaryButton(
                          onPressed: () => registerFarm(formKey),
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

  bool registerFarm(GlobalKey<FormBuilderState> formKey) {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) {
      return false;
    }
    //:TODO register farm logic
    return true;
  }
}
