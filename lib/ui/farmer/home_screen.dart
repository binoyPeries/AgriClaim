import 'package:agriclaim/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/components/default_appbar.dart';
import '../common/components/default_scaffold.dart';
import '../common/components/primary_button.dart';

import '../../generated/l10n.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({Key? key}) : super(key: key);

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultScaffold(
        appBar: const DefaultAppBar(title: "Home", backButtonVisible: true),
        body: PrimaryButton(
          onPressed: () => context.push(AgriClaimRoutes.registerFarm),
          text: 'Register Farm',
        ),
      ),
    );
  }
}
