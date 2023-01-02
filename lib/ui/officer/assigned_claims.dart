import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../models/claim.dart';
import '../../providers/claim_provider.dart';
import '../../routes.dart';
import '../constants/colors.dart';
import '../constants/enums.dart';

class AssignedClaimsPage extends ConsumerWidget {
  const AssignedClaimsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final claimList =
        ref.watch(claimListForOfficerProvider(ClaimStates.inReview));

    return claimList.when(
        data: (item) {
          List<ClaimInfoCard> claims = [];
          for (var claim in item) {
            claims.add(ClaimInfoCard(claim: claim));
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: claims,
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())));
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
        child: InkWell(
          onTap: () {
            context.push(AgriClaimRoutes.reviewSingleClaim, extra: claim);
          },
          splashColor: AgriClaimColors.secondaryColor.withOpacity(0.3),
          child: Ink(
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
