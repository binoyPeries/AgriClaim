import 'package:agriclaim/generated/l10n.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/forms/text_input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FarmerLoginPage extends StatelessWidget {
  const FarmerLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return DefaultScaffold(
      appBar: DefaultAppBar(title: S.of(context).login),
      body: Column(
        children: [
          FormBuilder(
              key: formKey,
              child: TextInputFormField(
                fieldName: S.of(context).username,
                label: S.of(context).username,
              )),
        ],
      ),
    );
  }
}
