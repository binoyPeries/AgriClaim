import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/providers/claim_provider.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/utils/helper_functions.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class ClaimsListPage extends ConsumerWidget {
  final ClaimStates claimType;
  const ClaimsListPage({Key? key, required this.claimType}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final claimList = ref.watch(claimListProvider(claimType));

    return DefaultScaffold(
      appBar: DefaultAppBar(
          title: getClaimPageName(claimType), backButtonVisible: true),
      body: claimList.when(
        data: (items) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 5.h),
                for (final claim in items) ClaimInfoCard(claim: claim)
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class ClaimInfoCard extends StatelessWidget {
  const ClaimInfoCard({
    Key? key,
    required this.claim,
  }) : super(key: key);

  final Claim claim;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 3.h),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SizedBox(
                height: 15.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Claim Reference: ",
                        style: valueTextStyle(context),
                        children: <TextSpan>[
                          TextSpan(
                              text: claim.claimReference,
                              style: dataTextStyle(context)),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    RichText(
                      text: TextSpan(
                        text: "Claim ID: ",
                        style: valueTextStyle(context),
                        children: <TextSpan>[
                          TextSpan(
                              text: claim.claimId,
                              style: dataTextStyle(context)),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    RichText(
                      text: TextSpan(
                        text: "Submitted Date: ",
                        style: valueTextStyle(context),
                        children: <TextSpan>[
                          TextSpan(
                              text: DateFormat('E, d MMM, yyyy')
                                  .format(claim.claimDate),
                              style: dataTextStyle(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              FontAwesomeIcons.chevronRight,
              color: AgriClaimColors.primaryColor,
              size: 4.h,
            )
          ],
        ),
      ),
    );
  }

  TextStyle dataTextStyle(BuildContext context) =>
      DefaultTextStyle.of(context).style.merge(TextStyle(fontSize: 2.h));

  TextStyle valueTextStyle(BuildContext context) {
    return DefaultTextStyle.of(context).style.merge(TextStyle(
        fontSize: 1.8.h,
        fontWeight: FontWeight.w600,
        color: AgriClaimColors.primaryColor));
  }
}
