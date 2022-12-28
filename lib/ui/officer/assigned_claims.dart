import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/claim_provider.dart';

class AssignedClaimsPage extends ConsumerWidget {
  const AssignedClaimsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final claimList = ref.watch(claimListForOfficerProvider);

    return claimList.when(
        data: (item) {
          List<Widget> claims = [];
          for (var claim in item) {
            claims.add(Text(claim.claimReference));
          }
          return SingleChildScrollView(
            child: Column(
              children: claims,
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())));
  }
}
