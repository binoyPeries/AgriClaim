import 'package:agriclaim/routes.dart';
import 'package:agriclaim/ui/constants/assets.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ClaimsHomePage extends ConsumerWidget {
  const ClaimsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          Text(
            "Hi, Welcome back!",
            style:
                TextStyle(fontSize: 4.h, color: AgriClaimColors.primaryColor),
          ),
          SizedBox(height: 4.h),
          const ClaimsOptions(
            option: "Pending",
            optionImage: AgriClaimAssets.claimPending,
            description: "View all pending claims",
            claimType: ClaimStates.pending,
          ),
          const ClaimsOptions(
            option: "In Review",
            optionImage: AgriClaimAssets.claimReview,
            description: "View all officer assigned claims",
            claimType: ClaimStates.inReview,
          ),
          const ClaimsOptions(
            option: "Completed",
            optionImage: AgriClaimAssets.claimCompleted,
            description: "View all completed claims",
            claimType: ClaimStates.completed,
          ),
          const ClaimsOptions(
            option: "Drafts",
            optionImage: AgriClaimAssets.claimDraft,
            description: "Edit draft claims",
            claimType: ClaimStates.draft,
          ),
        ],
      ),
    );
  }
}

class ClaimsOptions extends StatelessWidget {
  final String option;
  final String optionImage;
  final String description;
  final ClaimStates claimType;
  const ClaimsOptions({
    Key? key,
    required this.option,
    required this.optionImage,
    required this.description,
    required this.claimType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => context.push(AgriClaimRoutes.claimPath(claimType)),
          child: Container(
            height: 27.h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: AgriClaimColors.hintColor.withOpacity(0.3),
                  ),
                  child: SvgPicture.asset(
                    optionImage,
                    height: 19.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(option,
                        style: TextStyle(
                            fontSize: 2.2.h, fontWeight: FontWeight.w800)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: Text(description,
                        style: TextStyle(
                            fontSize: 1.8.h,
                            color: AgriClaimColors.tertiaryColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
