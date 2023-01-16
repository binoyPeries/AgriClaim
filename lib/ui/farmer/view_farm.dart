import 'package:agriclaim/providers/farm_provider.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/form_fields/form_text_field.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/utils/display_lat_long.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';
import '../../generated/l10n.dart';
import '../../models/farm.dart';
import '../common/components/submission_button.dart';

class ViewFarmPage extends ConsumerWidget {
  final Farm farm;
  const ViewFarmPage(this.farm, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final editable = ref.watch(farmEditableStateProvider);
    return DefaultScaffold(
      appBar: DefaultAppBar(
          title: editable ? "Edit Farm Information" : "View Farm Information",
          backButtonVisible: true),
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
                    Visibility(
                      visible: !editable,
                      child: Text(
                        "Farm Name",
                        style: TextStyle(
                            color: AgriClaimColors.primaryColor,
                            fontSize: 2.5.h,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    editable
                        ? FormTextField(
                            labelFontColor: AgriClaimColors.primaryColor,
                            labelFontWeight: FontWeight.w700,
                            labelFontSize: 2.5.h,
                            fieldName: "farmName",
                            label: "Farm Name",
                            initialValue: farm.farmName,
                            keyboardType: TextInputType.text,
                            validators: [FormBuilderValidators.min(1)],
                          )
                        : Text(
                            farm.farmName,
                            style: TextStyle(
                              fontSize: 2.3.h,
                            ),
                          ),
                    SizedBox(height: 2.h),
                    Visibility(
                      visible: !editable,
                      child: Text(
                        "Farm Address",
                        style: TextStyle(
                            color: AgriClaimColors.primaryColor,
                            fontSize: 2.5.h,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    editable
                        ? FormTextField(
                            labelFontColor: AgriClaimColors.primaryColor,
                            labelFontWeight: FontWeight.w700,
                            labelFontSize: 2.5.h,
                            fieldName: "farmAddress",
                            label: "Farm Address",
                            initialValue: farm.farmAddress,
                            keyboardType: TextInputType.text,
                            validators: [FormBuilderValidators.min(1)],
                          )
                        : Text(
                            farm.farmAddress,
                            style: TextStyle(
                              fontSize: 2.3.h,
                            ),
                          ),
                    SizedBox(height: 2.h),
                    FarmLocationsWidget(farm),
                    SizedBox(height: 3.h),
                    Visibility(
                      visible: editable,
                      child: PrimaryButton(
                          onPressed: () {
                            ref
                                .read(farmNotifierProvider(farm).notifier)
                                .addLocation();
                          },
                          buttonColor: Colors.white,
                          textColor: AgriClaimColors.primaryColor,
                          borderColor: AgriClaimColors.primaryColor,
                          text: S.of(context).add_another_location),
                    ),
                    SizedBox(height: 1.h),
                    Visibility(
                      visible: !editable,
                      child: PrimaryButton(
                          onPressed: () {
                            ref.read(farmEditableStateProvider.notifier).state =
                                true;
                          },
                          buttonColor: Colors.white,
                          textColor: AgriClaimColors.primaryColor,
                          borderColor: AgriClaimColors.primaryColor,
                          text: "Edit"),
                    ),
                    SizedBox(height: 3.h),
                    Visibility(
                      visible: editable,
                      child: SubmissionButton(
                        text: "Submit Updates",
                        onSubmit: () => updateFarm(formKey, context, ref,
                            ref.read(farmNotifierProvider(farm))),
                        afterSubmit: (context) {
                          ref.read(farmEditableStateProvider.notifier).state =
                              false;
                        },
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> updateFarm(GlobalKey<FormBuilderState> formKey,
      BuildContext context, WidgetRef ref, Farm farm) async {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    final farmRepository = ref.read(farmRepositoryProvider);
    if (!isValid) {
      return false;
    }
    String farmName = formKey.currentState?.value["farmName"];
    String farmAddress = formKey.currentState?.value["farmAddress"];
    farm.farmName = farmName;
    farm.farmAddress = farmAddress;
    farm.locations = farm.locations
        .where((element) => element["lat"] != 0 && element["long"] != 0)
        .toList();
    await farmRepository.updateFarm(farm);
    return true;
  }
}

class FarmLocationsWidget extends ConsumerWidget {
  final Farm farm;

  const FarmLocationsWidget(this.farm, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editable = ref.watch(farmEditableStateProvider);
    final farmLocations = ref.watch(farmNotifierProvider(farm)).locations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Locations",
          style: TextStyle(
              color: AgriClaimColors.primaryColor,
              fontSize: 2.5.h,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 1.2.h),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: farmLocations.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Location ${index + 1}",
                    style: TextStyle(
                      fontSize: 2.3.h,
                      fontWeight: FontWeight.w600,
                    )),
                Row(
                  children: [
                    Text(convertMapToLatLong(farmLocations[index]),
                        style: TextStyle(
                          fontSize: 2.1.h,
                        )),
                    const Spacer(),
                    Visibility(
                      visible: editable,
                      child: SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AgriClaimColors.tertiaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          child: GestureDetector(
                            onTap: () async {
                              await Geolocator.isLocationServiceEnabled();
                              await Geolocator.checkPermission();
                              await Geolocator.requestPermission();

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      Navigator.of(context).pop(true);
                                    });
                                    return const AlertDialog(
                                      title: Text(
                                          "Pinpointing location. Please wait."),
                                    );
                                  });
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high);

                              ref
                                  .read(farmNotifierProvider(farm).notifier)
                                  .updateLocation({
                                'lat': position.latitude,
                                'long': position.longitude
                              }, index);
                            },
                            child: const SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: Icon(
                                Icons.add_location_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: index > 3,
                      child: SizedBox(
                        width: 1.h,
                      ),
                    ),
                    Visibility(
                      visible: editable && index > 3,
                      child: SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          child: GestureDetector(
                            onTap: () async {
                              ref
                                  .read(farmNotifierProvider(farm).notifier)
                                  .removeLocation(index);
                            },
                            child: const SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: Icon(
                                FontAwesomeIcons.circleXmark,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            );
          },
        ),
      ],
    );
  }
}
