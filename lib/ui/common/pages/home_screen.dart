import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import '../components/default_appbar.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  const HomeScreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultScaffold(
        appBar: DefaultAppBar(title: "Home", backButtonVisible: true),
        body: Container(
          child: PrimaryButton(
            onPressed: () => context.push(AgriClaimRoutes.registerFarm),
            text: 'Register Farm',
          ),
        ),
      ),
    );
  }
}
