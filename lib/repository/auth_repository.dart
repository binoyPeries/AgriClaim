import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Stream<User?> get authStateChange => _auth.idTokenChanges();
  String verificationId = "";
  Future<void> phoneSignIn({required String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      print("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
  }

  _onCodeTimeout(String timeout) {
    return null;
  }
}
