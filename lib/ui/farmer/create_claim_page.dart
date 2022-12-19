import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/form_fields/form_dropdown_field.dart';
import 'package:flutter/material.dart';

class CreateClaimPage extends StatelessWidget {
  const CreateClaimPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        appBar: const DefaultAppBar(
          title: "Create Claim",
          backButtonVisible: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // FormDropdownField<Farm>(
              //     fieldName: "farmId", label: "Farm", items: ["xx", "ss"]),
            ],
          ),
        ));
  }
}
