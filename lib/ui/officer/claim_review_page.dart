import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/models/claim_media.dart';
import 'package:agriclaim/providers/claim_provider.dart';
import 'package:agriclaim/ui/common/components/claim_image_viewer.dart';
import 'package:agriclaim/ui/common/components/claim_video_player.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/farmer/claim_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            const MediaAcceptedInfo(),
            SizedBox(height: 1.h),
            const MediaRejectedInfo(),
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
                    Consumer(
                      builder: (context, ref, child) {
                        final accepted = ref.watch(claimAcceptedStateProvider);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                PrimaryButton(
                                    onPressed: () {
                                      ref
                                          .read(claimAcceptedStateProvider
                                              .notifier)
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
                                        .read(
                                            claimAcceptedStateProvider.notifier)
                                        .state = false;
                                  },
                                  buttonColor:
                                      accepted ? Colors.white : Colors.red,
                                  textColor:
                                      accepted ? Colors.red : Colors.white,
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
                              onSubmit: () => updateClaim(formKey, context, ref,
                                  claim.claimId, accepted),
                              afterSubmit: (context) {
                                context.pop();
                              },
                              buttonColor: Colors.white,
                              textColor: AgriClaimColors.tertiaryColor,
                            ),
                          ],
                        );
                      },
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
    await claimRepository.updateClaim(
        claimId: claimId,
        data: formKey.currentState?.value ?? {},
        accepted: accepted);

    return true;
  }
}
