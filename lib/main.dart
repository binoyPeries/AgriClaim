import 'package:agriclaim/routes.dart';
import 'package:agriclaim/theme.dart';
import 'package:agriclaim/ui/common/pages/router_error_page.dart';
import 'package:agriclaim/ui/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(ProviderScope(observers: const [StateLogger()], child: AgriClaim()));
}

class AgriClaim extends StatelessWidget {
  AgriClaim({Key? key}) : super(key: key);

  final _router = GoRouter(
    routes: AgriClaimRoutes.routes,
    errorBuilder: (_, __) => const RouterErrorPage(),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        title: 'AgriClaim',
        debugShowCheckedModeBanner: false,
        theme: AgriClaimTheme.theme,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        routerDelegate: _router.routerDelegate,
      );
    });
  }
}
