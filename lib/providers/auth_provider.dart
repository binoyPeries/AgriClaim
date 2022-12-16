import 'package:agriclaim/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(FirebaseAuth.instance));

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.read(authRepositoryProvider).authStateChange);
