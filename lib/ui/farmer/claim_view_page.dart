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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ClaimViewPage extends ConsumerWidget {
  final Claim claim;
  const ClaimViewPage({required this.claim, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ClaimInfoPair(value: "Claim Reference", data: claim.claimReference),
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
            SizedBox(height: 3.h),
            const SectionDivider(sectionName: "Claim Status Details"),
            SizedBox(height: 2.h),
            ClaimInfoPair(
                value: "Claim Status", data: getClaimStatus(claim.status)),
            ClaimInfoPair(
                value: "Assigned Officer",
                data: claim.assignedOfficer ?? "Not assigned"),
            ClaimInfoPair(
                value: "Compensation",
                data: claim.compensation != 0.0
                    ? "Rs. ${claim.compensation.toString()}"
                    : "Not decided"),
            SizedBox(height: 1.h),
            NoteSection(
                value: "Officer Note: ",
                data: claim.officerNote ?? "No notes provided"),
            if (claim.approved != null)
              ClaimAcceptanceCard(accepted: claim.approved ?? false),
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
          ],
        ),
      ),
    );
  }
}

class ClaimAcceptanceCard extends StatelessWidget {
  final bool accepted;
  const ClaimAcceptanceCard({
    Key? key,
    required this.accepted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      child: Container(
        height: 6.5.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: accepted
                  ? AgriClaimColors.secondaryColor
                  : AgriClaimColors.warningRedColor,
              width: 0.2.h),
        ),
        child: Container(
          margin: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                color: accepted
                    ? AgriClaimColors.secondaryColor
                    : AgriClaimColors.warningRedColor,
                width: 0.2.h),
          ),
          child: Center(
            child: Text(
              accepted ? "Approved" : "Rejected",
              style: TextStyle(
                color: accepted
                    ? AgriClaimColors.secondaryColor
                    : AgriClaimColors.warningRedColor,
                fontSize: 2.7.h,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
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

class MediaAcceptedInfo extends StatelessWidget {
  const MediaAcceptedInfo({Key? key}) : super(key: key);

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
            " - The provided photo/video is within the farm boundaries",
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

class MediaRejectedInfo extends StatelessWidget {
  const MediaRejectedInfo({Key? key}) : super(key: key);

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
            " - The provided  photo/video is NOT within the farm boundaries",
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
