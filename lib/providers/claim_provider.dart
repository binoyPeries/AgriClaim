import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/repository/claim_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final claimRepositoryProvider = Provider<ClaimRepository>((ref) {
  final currentUser = ref.watch(authRepositoryProvider).getLoggedInUser();
  return ClaimRepository(
      FirebaseFirestore.instance, FirebaseStorage.instance, currentUser?.uid);
});
