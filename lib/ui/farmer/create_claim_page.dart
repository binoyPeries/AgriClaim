import 'package:agriclaim/models/farm.dart';
import 'package:agriclaim/providers/claim_provider.dart';
import 'package:agriclaim/providers/farm_provider.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/submission_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_dropdown_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_image_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_area_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/common/form_fields/form_video_field.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CreateClaimPage extends ConsumerWidget {
  CreateClaimPage({super.key});
  List<XFile> imageList = [];
  XFile? video;
  setImageList(List<XFile> photoList) {
    imageList = photoList;
  }

  setVideo(XFile capturedVideo) {
    video = capturedVideo;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

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
                const FormTextField(
                    fieldName: "claimReference", label: "Claim Reference"),
                SizedBox(height: 2.h),
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
                  setImageListInParent: setImageList,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Video (max 30 seconds)",
                  style: TextStyle(
                      color: AgriClaimColors.secondaryColor,
                      fontSize: 2.2.h,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2.2.h),
                Text(
                  "Submit a 30 seconds video clearly showing the damaged crop area. "
                  "This video submission is optional.",
                  style: TextStyle(
                    fontSize: 1.8.h,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 2.5.h),
                FormVideoField(
                  fieldName: "claimVideo",
                  maxDurationInSec: 5,
                  setVideoOnParent: setVideo,
                ),
                SizedBox(height: 2.5.h),
                const FormTextAreaField(
                  fieldName: "farmerNote",
                  label: "Note",
                  maxLen: 100,
                  required: false,
                ),
                SizedBox(height: 5.h),
                SubmissionButton(
                  text: "Submit",
                  onSubmit: () => submitClaim(formKey, context, ref),
                  afterSubmit: (context) {
                    context.pop();
                  },
                ),
                SizedBox(height: 3.5.h),
              ],
            ),
          ),
        ));
  }

  Future<bool> submitClaim(GlobalKey<FormBuilderState> formKey,
      BuildContext context, WidgetRef ref) async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    final claimRepository = ref.read(claimRepositoryProvider);
    if (!isValid) {
      return false;
    }
    Map<String, dynamic> mediaData = {};
    mediaData["claimPhotos"] = imageList;
    mediaData["claimVideo"] = video;
    await claimRepository.createClaim(
        mediaData: mediaData, data: formKey.currentState?.value ?? {});

    return true;
  }
}
