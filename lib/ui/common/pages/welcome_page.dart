import 'package:agriclaim/routes.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/constants/assets.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(AgriClaimAssets.agriClaimLogo128),
              SizedBox(height: 2.h),
              Center(
                child: Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 4.h, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  "Please select your profile type",
                  style: TextStyle(
                      fontSize: 2.5.h, color: AgriClaimColors.hintColor),
                ),
              ),
              SizedBox(height: 5.h),
              PrimaryButton(
                  onPressed: () => context
                      .push(AgriClaimRoutes.userLoginPath(UserRoles.farmer)),
                  text: "Farmer",
                  buttonColor: AgriClaimColors.primaryColor),
              SizedBox(height: 2.h),
              PrimaryButton(
                  onPressed: () => context
                      .push(AgriClaimRoutes.userLoginPath(UserRoles.officer)),
                  text: "Officer",
                  buttonColor: AgriClaimColors.primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
