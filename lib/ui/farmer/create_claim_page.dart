import 'package:agriclaim/models/farm.dart';
import 'package:agriclaim/providers/farm_provider.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/form_fields/form_dropdown_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_image_field.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CreateClaimPage extends StatelessWidget {
  const CreateClaimPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final List<XFile> list = [];
    return DefaultScaffold(
        appBar: const DefaultAppBar(
          title: "Create Claim",
          backButtonVisible: true,
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 4.h),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, _) {
                    final farmsList = ref.watch(farmListProvider);
                    return farmsList.when(
                      data: (data) {
                        return FormDropdownField<Farm>(
                          fieldName: "farmId",
                          label: "Select Farm",
                          items: data,
                          setValue: (farm) => farm.id,
                          setDisplayText: (farm) => farm.farmName,
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, st) => Center(child: Text(e.toString())),
                    );
                  },
                ),
                SizedBox(height: 4.h),
                Text(
                  "Photos (max 10)",
                  style: TextStyle(
                      color: AgriClaimColors.secondaryColor,
                      fontSize: 2.2.h,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2.2.h),
                Text(
                  "Submit maximum of 10 picture that clearly shows the damaged crop area. "
                  "These photos will be vital in reviewing your claim.",
                  style: TextStyle(
                    fontSize: 1.8.h,
                  ),
                  textAlign: TextAlign.justify,
                ),
                FormImageField(
                  fieldName: "claimPhotos",
                  maxImages: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
