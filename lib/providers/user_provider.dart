import 'package:agriclaim/models/farmer.dart';
import 'package:agriclaim/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final currentUser = ref.watch(authRepositoryProvider).getLoggedInUser();
  return UserRepository(FirebaseFirestore.instance, currentUser?.uid);
});

final farmerDetailsProvider = StreamProvider.autoDispose<Farmer?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);

  final phoneNumber = authRepository.getLoggedInUserPhoneNumber();
  return userRepository.getLoggedInFarmerDetails(phoneNumber);
});

final profileInEditModeProvider = StateProvider<bool>((ref) {
  return false;
});
