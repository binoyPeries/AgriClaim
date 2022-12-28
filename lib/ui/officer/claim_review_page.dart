import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/models/claim_media.dart';
import 'package:agriclaim/providers/claim_provider.dart';
import 'package:agriclaim/ui/common/components/claim_image_viewer.dart';
import 'package:agriclaim/ui/common/components/claim_video_player.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../common/components/primary_button.dart';
import '../common/components/submission_button.dart';
import '../common/form_fields/form_text_area_field.dart';
import '../common/form_fields/form_text_field.dart';

class ClaimReviewPage extends ConsumerWidget {
  final Claim claim;
  const ClaimReviewPage({required this.claim, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accepted = ref.watch(claimAcceptedStateProvider);
    final formKey = GlobalKey<FormBuilderState>();

    return DefaultScaffold(
      appBar: const DefaultAppBar(
        title: "Claim Details",
        backButtonVisible: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 3.h),
            const SectionDivider(sectionName: "Basic Details"),
            SizedBox(height: 2.h),
            ClaimInfoPair(value: "Claim ID", data: claim.claimId),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final farm = ref.watch(claimFarmProvider(claim.farmId));
                return farm.when(
                  data: (data) =>
                      ClaimInfoPair(value: "Farm Name", data: data.farmName),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text(e.toString())),
                );
              },
            ),
            ClaimInfoPair(
                value: "Submission Date",
                data: DateFormat('E, d MMM, yyyy').format(claim.claimDate)),
            SizedBox(height: 1.h),
            NoteSection(
                value: "Farmer Note: ",
                data: claim.farmerNote ?? "No notes provided"),
            SizedBox(height: 2.h),
            const SectionDivider(sectionName: "Submitted Photos"),
            SizedBox(height: 2.h),
            ClaimImagesViewer(images: claim.claimPhotos),
            SizedBox(height: 3.h),
            const SectionDivider(sectionName: "Submitted Video"),
            SizedBox(height: 3.h),
            if (claim.claimVideo != null)
              VideoDetailsCard(video: claim.claimVideo as ClaimMedia),
            SizedBox(height: 2.h),
            if (claim.claimVideo != null)
              ClaimVideoPlayer(video: claim.claimVideo as ClaimMedia),
            SizedBox(height: 3.h),
            Text(
              "NOTE:",
              style: TextStyle(
                fontSize: 2.4.h,
                fontWeight: FontWeight.w700,
                color: AgriClaimColors.primaryColor,
              ),
            ),
            SizedBox(height: 1.h),
            const PhotoAcceptedInfo(),
            SizedBox(height: 1.h),
            const PhotoRejectedInfo(),
            SizedBox(height: 3.h),
            FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FormTextAreaField(
                      fieldName: "officerNote",
                      label: "Notes",
                      maxLines: 3,
                      required: false,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PrimaryButton(
                            onPressed: () {
                              ref
                                  .read(claimAcceptedStateProvider.notifier)
                                  .state = true;
                            },
                            buttonColor: accepted
                                ? AgriClaimColors.primaryColor
                                : Colors.white,
                            textColor: accepted
                                ? Colors.white
                                : AgriClaimColors.primaryColor,
                            borderColor: AgriClaimColors.primaryColor,
                            text: "Approve Claim"),
                        PrimaryButton(
                          onPressed: () {
                            ref
                                .read(claimAcceptedStateProvider.notifier)
                                .state = false;
                          },
                          buttonColor: accepted ? Colors.white : Colors.red,
                          textColor: accepted ? Colors.red : Colors.white,
                          borderColor: Colors.red,
                          text: "Reject Claim",
                        ),
                      ],
                    ),
                    Visibility(
                      visible: accepted,
                      child: FormTextField(
                        fieldName: "compensation",
                        label: "Compensation Amount",
                        keyboardType: TextInputType.number,
                        validators: [FormBuilderValidators.min(1)],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SubmissionButton(
                      text: "Submit Claim",
                      onSubmit: () => updateClaim(
                          formKey, context, ref, claim.claimId, accepted),
                      afterSubmit: (context) {
                        context.pop();
                      },
                      buttonColor: Colors.white,
                      textColor: AgriClaimColors.tertiaryColor,
                    ),
                  ],
                )),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  Future<bool> updateClaim(
      GlobalKey<FormBuilderState> formKey,
      BuildContext context,
      WidgetRef ref,
      String claimId,
      bool accepted) async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    final claimRepository = ref.read(claimRepositoryProvider);
    if (!isValid) {
      return false;
    }
    print(formKey.currentState?.value);
    await claimRepository.updateClaim(
        claimId: claimId,
        data: formKey.currentState?.value ?? {},
        accepted: accepted);

    return true;
  }
}

class VideoDetailsCard extends StatelessWidget {
  final ClaimMedia video;
  const VideoDetailsCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClaimInfoPair(
            value: "Submitted Time: ",
            data: getDateTimeIn12HrFormat(video.capturedDateTime)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 1.h),
            Text(
              "Accepted: ",
              style: TextStyle(
                  fontSize: 2.4.h,
                  fontWeight: FontWeight.w700,
                  color: AgriClaimColors.primaryColor),
            ),
            SizedBox(width: 1.h),
            video.accepted
                ? Icon(
                    FontAwesomeIcons.circleCheck,
                    color: AgriClaimColors.secondaryColor,
                    size: 4.h,
                  )
                : Icon(
                    FontAwesomeIcons.circleXmark,
                    color: Colors.red,
                    size: 4.h,
                  ),
          ],
        ),
      ],
    );
  }
}

class PhotoAcceptedInfo extends StatelessWidget {
  const PhotoAcceptedInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          FontAwesomeIcons.circleCheck,
          color: AgriClaimColors.secondaryColor,
          size: 3.h,
        ),
        Flexible(
          child: Text(
            " - The provided photo is within the farm boundaries",
            style: TextStyle(
              fontSize: 2.h,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

class PhotoRejectedInfo extends StatelessWidget {
  const PhotoRejectedInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          FontAwesomeIcons.circleXmark,
          color: Colors.red,
          size: 3.h,
        ),
        Flexible(
          child: Text(
            " - The provided photo is NOT within the farm boundaries",
            style: TextStyle(
              fontSize: 2.h,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

class SectionDivider extends StatelessWidget {
  final String sectionName;
  const SectionDivider({Key? key, required this.sectionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(
          child: Divider(
            color: AgriClaimColors.primaryColor,
            height: 0,
            thickness: 1,
          ),
        ),
        SizedBox(width: 1.h),
        Text(
          sectionName,
          style: TextStyle(
              fontSize: 2.6.h,
              fontWeight: FontWeight.w700,
              color: AgriClaimColors.primaryColor),
        ),
        SizedBox(width: 1.h),
        const Expanded(
          child: Divider(
            color: AgriClaimColors.primaryColor,
            height: 0,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class ClaimInfoPair extends StatelessWidget {
  final String value;
  final String data;
  const ClaimInfoPair({Key? key, e, required this.value, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 1.h),
          Text(
            "$value :",
            style: TextStyle(
                fontSize: 2.4.h,
                fontWeight: FontWeight.w700,
                color: AgriClaimColors.primaryColor),
          ),
          SizedBox(width: 1.h),
          Flexible(
            child: Text(
              data,
              style: TextStyle(
                fontSize: 2.2.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoteSection extends StatelessWidget {
  final String value;
  final String data;
  const NoteSection({Key? key, required this.value, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 1.h),
          child: Text(
            value,
            style: TextStyle(
                fontSize: 2.4.h,
                fontWeight: FontWeight.w700,
                color: AgriClaimColors.primaryColor),
          ),
        ),
        SizedBox(width: 1.h),
        Padding(
          padding: EdgeInsets.only(left: 1.h),
          child: Text(
            data,
            style: TextStyle(
              fontSize: 2.2.h,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
