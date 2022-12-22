import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: PrimaryButton(
          text: "Logout",
          onPressed: () async {
            final temp = ref.read(authRepositoryProvider);
            await temp.signOut();
          }),
    );
  }
}
