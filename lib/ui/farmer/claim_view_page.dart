import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/ui/common/components/default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClaimViewPage extends ConsumerWidget {
  final Claim claim;
  const ClaimViewPage({required this.claim, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultScaffold(body: Text(claim.claimId));
  }
}
