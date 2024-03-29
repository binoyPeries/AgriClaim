import 'package:agriclaim/models/farm.dart';
import 'package:agriclaim/providers/auth_provider.dart';
import 'package:agriclaim/providers/farm_provider.dart';
import 'package:agriclaim/repository/claim_repository.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/claim.dart';

final claimRepositoryProvider = Provider<ClaimRepository>((ref) {
  final currentUser = ref.watch(authRepositoryProvider).getLoggedInUser();
  return ClaimRepository(
      FirebaseFirestore.instance, FirebaseStorage.instance, currentUser?.uid);
});

/// displays the list of claims for a given claimType
final claimListProvider = StreamProvider.autoDispose
    .family<List<Claim>, ClaimStates>((ref, claimType) {
  final claimRepository = ref.watch(claimRepositoryProvider);
  final claimList = claimRepository.getClaimsList(claimType);
  return claimList;
});

/// gets the farm for a given farm ID
final claimFarmProvider =
    FutureProvider.autoDispose.family<Farm, String>((ref, farmId) {
  final value = ref.watch(farmRepositoryProvider).getFarm(farmId);
  return value;
});

/// gets the claim list for an officer (filtered by assignedOfficer attribute in database)
final claimListForOfficerProvider = StreamProvider.autoDispose
    .family<List<Claim>, ClaimStates>((ref, claimType) {
  final claimRepository = ref.watch(claimRepositoryProvider);
  final claimList = claimRepository.getClaimsListForOfficer(claimType);
  return claimList;
});

/// for claim acceptance by officer
final claimAcceptedStateProvider = StateProvider<bool>((ref) {
  return true;
});

final searchResultsProvider = StreamProvider.autoDispose<List<Claim>>((ref) {
  final claimRepository = ref.watch(claimRepositoryProvider);
  final value = claimRepository.searchClaims();
  return value;
});
