import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({Key? key}) : super(key: key);

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(S.of(context).farmer),
    );
  }
}
