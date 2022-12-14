import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  const DefaultScaffold({Key? key, this.appBar, required this.body})
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: body,
          ),
        ),
      ),
    );
  }
}
