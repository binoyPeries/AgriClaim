import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/providers/claim_provider.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/utils/helper_functions.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          ],
        ),
      ),
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
