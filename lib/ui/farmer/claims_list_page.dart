import 'package:agriclaim/ui/constants/enums.dart';
import 'package:flutter/material.dart';

class ClaimsListPage extends StatelessWidget {
  final ClaimStates claimType;
  const ClaimsListPage({Key? key, required this.claimType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(claimType.name),
    ));
  }
}
