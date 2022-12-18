import 'package:agriclaim/repository/farm_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final farmRepositoryProvider = Provider<FarmRepository>(
    (ref) => FarmRepository(FirebaseFirestore.instance));

final farmLocationCountStateProvider =
    StateNotifierProvider<FarmLocationsNotifier, List>((ref) {
  return FarmLocationsNotifier();
});

class FarmLocationsNotifier extends StateNotifier<List> {
  FarmLocationsNotifier() : super([]);

  void addLocation(Map values) {
    state = [...state, values];
  }

  void removeLocation(int index) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = state.removeAt(index);
  }
}