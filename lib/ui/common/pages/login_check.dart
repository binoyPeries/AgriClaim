import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/ui/common/pages/splash_screen.dart';
import 'package:agriclaim/ui/common/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_page.dart';
import 'home_screen.dart';

class LoginCheck extends ConsumerWidget {
  const LoginCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
        data: (user) {
          //TODO: replace with apt user home screen
          if (user != null) return const HomeScreen();

          return const WelcomePage();
        },
        loading: () => const SplashScreen(),
        error: (e, trace) => const ErrorPage());
  }
}
