import 'package:agriclaim/providers/farm_provider.dart';
import 'package:agriclaim/ui/common/components/default_appbar.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/common/utils/display_lat_long.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    return SafeArea(
      child: DefaultScaffold(
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
                      Text(
                        "Farm Name",
                        style: TextStyle(
                            color: AgriClaimColors.primaryColor,
                            fontSize: 2.2.h,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 1.2.h),
                      Text(farm.farmName),
                      SizedBox(height: 2.h),
                      Text(
                        "Farm Address",
                        style: TextStyle(
                            color: AgriClaimColors.primaryColor,
                            fontSize: 2.2.h,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 1.2.h),
                      Text(farm.farmAddress),
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
                      SizedBox(height: 3.h),
                      editable
                          ? PrimaryButton(
                              onPressed: () {
                                ref
                                    .read(farmEditableStateProvider.notifier)
                                    .state = false;
                              },
                              buttonColor: Colors.white,
                              textColor: AgriClaimColors.primaryColor,
                              borderColor: AgriClaimColors.primaryColor,
                              text: "Not editing")
                          : PrimaryButton(
                              onPressed: () {
                                ref
                                    .read(farmEditableStateProvider.notifier)
                                    .state = true;
                              },
                              buttonColor: Colors.white,
                              textColor: AgriClaimColors.primaryColor,
                              borderColor: AgriClaimColors.primaryColor,
                              text: "Edit"),
                      SizedBox(height: 3.h),
                      Visibility(
                        visible: editable,
                        child: SubmissionButton(
                          text: S.of(context).register,
                          onSubmit: () => updateFarm(formKey, context, ref,
                              ref.read(farmNotifierProvider(farm))),
                          afterSubmit: (context) {
                            context.pop();

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
              fontSize: 2.2.h,
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
                        fontSize: 2.2.h, fontWeight: FontWeight.w600)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(convertMapToLatLong(farmLocations[index])),
                    Visibility(
                      visible: editable,
                      child: SizedBox(
                        height: 35.0,
                        width: 35.0,
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
