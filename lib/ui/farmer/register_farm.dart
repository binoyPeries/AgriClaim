import 'package:agriclaim/providers/farm_provider.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';
import '../../generated/l10n.dart';
import '../../routes.dart';
import '../common/components/submission_button.dart';
import '../common/form_fields/form_text_area_field.dart';
import '../common/form_fields/location_addition_text_box.dart';

class RegisterFarmPage extends ConsumerWidget {
  const RegisterFarmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return SafeArea(
      child: DefaultScaffold(
        appBar: const DefaultAppBar(
            title: "Register Farm", backButtonVisible: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 2.h),
                      FormTextField(
                        fieldName: "farmName",
                        label: "Farm Name (ex: Farm 1)",
                        keyboardType: TextInputType.text,
                        validators: [FormBuilderValidators.min(1)],
                      ),
                      SizedBox(height: 2.h),
                      FormTextAreaField(
                        fieldName: "farmAddress",
                        label: S.of(context).farm_address,
                        maxLines: 3,
                        validators: [FormBuilderValidators.min(1)],
                      ),
                      FarmLocationsWidget(),
                      SizedBox(height: 3.h),
                      SubmissionButton(
                        text: S.of(context).register,
                        onSubmit: () => registerFarm(formKey, context, ref),
                        afterSubmit: (context) {
                          context.push(AgriClaimRoutes.farmerHome);
                          ref
                              .read(farmLocationCountStateProvider.notifier)
                              .clearList();
                        },
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> registerFarm(GlobalKey<FormBuilderState> formKey,
      BuildContext context, WidgetRef ref) async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    final farmRepository = ref.read(farmRepositoryProvider);
    final locationsList = ref.watch(farmLocationCountStateProvider);

    if (!isValid) {
      return false;
    }

    Map farmData = formKey.currentState?.value ?? {};
    locationsList
        .removeWhere((element) => element["lat"] == 0 && element["long"] == 0);
    Map<String, dynamic> data = {...farmData, "locations": locationsList};
    print(data);
    await farmRepository.addFarm(data);

    return true;
  }
}

class FarmLocationsWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsList = ref.watch(farmLocationCountStateProvider);

    return Column(
      children: [
        ListView.builder(
          itemCount: locationsList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return FormLocationAdditionField(
                index: index,
                fieldName: '',
                hintText: "Location ${index + 5}",
                label: "",
                notRemovable: false,
                onPressed: () async {
                  await Geolocator.isLocationServiceEnabled();
                  await Geolocator.checkPermission();
                  await Geolocator.requestPermission();

                  showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pop(true);
                        });
                        return const AlertDialog(
                          title: Text("Pinpointing location. Please wait."),
                        );
                      });
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  locationsList[index] = {
                    'lat': position.latitude,
                    'long': position.longitude
                  };

                  ref
                      .read(farmLocationCountStateProvider.notifier)
                      .addLocationAtIndex(index, {
                    'lat': position.latitude,
                    'long': position.longitude
                  });
                });
          },
        ),
        SizedBox(height: 3.h),
        PrimaryButton(
            onPressed: () {
              ref
                  .read(farmLocationCountStateProvider.notifier)
                  .addLocation({'lat': 0, 'long': 0});
            },
            buttonColor: Colors.white,
            textColor: AgriClaimColors.primaryColor,
            borderColor: AgriClaimColors.primaryColor,
            text: S.of(context).add_another_location),
        SizedBox(height: 3.h),
      ],
    );
  }
}
