import 'package:agriclaim/repository/farm_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final farmRepositoryProvider = Provider<FarmRepository>(
    (ref) => FarmRepository(FirebaseFirestore.instance));

final farmLocationStateProvider = StateProvider<int>((ref) {
  return 0;
});
