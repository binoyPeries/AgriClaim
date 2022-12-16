import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/ui/common/utils/helper_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/login_error_provider.dart';
import '../repository/auth_repository.dart';
import '../ui/constants/enums.dart';

class LoginController extends StateNotifier<LoginStates> {
  LoginController(this.ref) : super(LoginStates.initializing);

  final Ref ref;

  void login(String phoneNumber, String password) async {
    state = LoginStates.loading;
    String email = convertPhoneToEmail(phoneNumber);
    try {
      await ref.read(authRepositoryProvider).signInWithEmailAndPassword(
            email,
            password,
          );
      state = LoginStates.successful;
    } on AuthException catch (e) {
      ref.read(loginErrorStateProvider.notifier).state = e.message;
      state = LoginStates.failed;
    }
  }

  void signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginStates>((ref) {
  return LoginController(ref);
});
