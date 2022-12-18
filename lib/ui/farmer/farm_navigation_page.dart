import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';

class FarmNavigationPage extends StatelessWidget {
  const FarmNavigationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryButton(
          onPressed: () => context.push(AgriClaimRoutes.registerFarm),
          text: 'View Farms',
        ),
        PrimaryButton(
          onPressed: () => context.push(AgriClaimRoutes.registerFarm),
          text: 'Register Farm',
        ),
      ],
    );
  }
}
