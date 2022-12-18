import 'package:agriclaim/ui/common/utils/agriclaim_exception.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../ui/common/utils/helper_functions.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  Future<User?> createUserWithPhoneAndPassword(
      String phone, String password, UserRoles userType) async {
    String email = convertPhoneToEmail(phone);
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // To set the user type, here user type will be set as the display name for convenience
      await result.user?.updateDisplayName(userType.name);
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('This mobile number already in use');
      } else if (e.code == 'weak-password') {
        throw AuthException('Provided password is weak');
      } else {
        throw AuthException('An error occurred. Please try again later');
      }
    }
  }

  Future<User?> signInWithPhoneAndPassword(
      String phone, String password) async {
    String email = convertPhoneToEmail(phone);
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No account found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Incorrect phone number or password');
      } else {
        throw AuthException('An error occurred. Please try again later');
      }
    }
  }

  User? getLoggedInUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthException implements AgriclaimException {
  final String message;

  AuthException(this.message);

  @override
  String get errorMsg => message;
}
