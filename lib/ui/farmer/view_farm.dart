import 'package:agriclaim/providers/farm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/components/default_appbar.dart';
import '../common/components/default_scaffold.dart';

class ViewFarmPage extends ConsumerWidget {
  const ViewFarmPage({Key? key}) : super(key: key);

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
          List<ListTile> farms = [];
          for (var element in item) {
            farms.add(ListTile(
              title: Text(element.farmName.toString()),
              subtitle: Text(element.locations.toString()),
            ));
          }
          return Column(
            children: farms,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    ));
  }
}
