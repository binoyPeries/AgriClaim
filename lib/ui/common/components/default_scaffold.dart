import 'package:agriclaim/providers/connectivity_provider.dart';
import 'package:agriclaim/ui/common/components/info_snack_bar.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class DefaultScaffold extends ConsumerWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavBar;
  final Widget? floatingButton;
  const DefaultScaffold(
      {Key? key,
      this.appBar,
      required this.body,
      this.bottomNavBar,
      this.floatingButton})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<NetworkStatus>(networkAwareProvider, (previous, current) {
      if ((previous != current) && (current == NetworkStatus.off)) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          infoSnackBar(
              msg: "You are in offline mode",
              time: const Duration(hours: 1),
              ),
        );
      }
      if ((previous != current) &&
          (previous == NetworkStatus.off) &&
          (current == NetworkStatus.on)) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          infoSnackBar(
              msg: "You are back online",
              color: AgriClaimColors.primaryColor,
              icon: FontAwesomeIcons.circleCheck,
              ),
        );
      }
    });
    final appTheme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: appTheme.primaryColorDark,
        statusBarBrightness: appTheme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: appBar,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: body,
          ),
          bottomNavigationBar: bottomNavBar,
          floatingActionButton: floatingButton,
        ),
      ),
    );
  }
}
