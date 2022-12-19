import 'package:agriclaim/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final currentUser = ref.read(authRepositoryProvider).getLoggedInUser();
  return UserRepository(FirebaseFirestore.instance, currentUser?.uid);
});
