import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultScaffold extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: body,
          ),
          bottomNavigationBar: bottomNavBar,
          floatingActionButton: floatingButton,
        ),
      ),
    );
  }
}
