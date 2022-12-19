import 'package:agriclaim/providers/farm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/components/default_appbar.dart';
import '../common/components/default_scaffold.dart';
import '../common/components/farm_list_tile.dart';

class ViewFarmListPage extends ConsumerWidget {
  const ViewFarmListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamAsyncValue = ref.watch(farmListProvider);
    return SafeArea(
      child: DefaultScaffold(
        appBar: const DefaultAppBar(
          title: "Farms",
        ),
        body: streamAsyncValue.when(
          data: (item) {
            List<FarmListTile> farms = [];
            for (var element in item) {
              farms.add(FarmListTile(
                  onPressed: () {},
                  title: "Farm Name: ${element.farmName.toString()}",
                  description: element.locations,
                  subtitle: "Farm Address: ${element.farmAddress.toString()}"));
            }
            return SingleChildScrollView(
              child: Column(
                children: farms,
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text(e.toString())),
        ),
      ),
    );
  }
}
