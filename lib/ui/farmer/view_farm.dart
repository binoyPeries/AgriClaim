import 'package:flutter/material.dart';

import '../common/components/default_appbar.dart';
import '../common/components/default_scaffold.dart';

class ViewFarmPage extends StatelessWidget {
  const ViewFarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultScaffold(
        appBar: const DefaultAppBar(title: "View Farms"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
