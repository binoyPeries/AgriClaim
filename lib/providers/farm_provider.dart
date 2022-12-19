import 'package:agriclaim/models/farm.dart';
import 'package:agriclaim/repository/farm_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

final farmRepositoryProvider = Provider<FarmRepository>((ref) {
  final currentUser = ref.watch(authRepositoryProvider).getLoggedInUser();
  return FarmRepository(FirebaseFirestore.instance, currentUser?.uid);
});

final farmLocationCountStateProvider =
    StateNotifierProvider<FarmLocationsNotifier, List>((ref) {
  return FarmLocationsNotifier();
});

final farmEditableStateProvider = StateProvider<bool>((ref) {
  return false;
});

// returns the stream of changes in the farm documents where the owner ID is the logged in user's ID
final farmListProvider = StreamProvider.autoDispose<List<Farm>>((ref) {
  final farmRepository = ref.watch(farmRepositoryProvider);
  final farmsList = farmRepository.getLoggedInUserFarms();
  return farmsList;
});

class FarmLocationsNotifier extends StateNotifier<List> {
  FarmLocationsNotifier()
      : super([
          {'lat': 0, 'long': 0},
          {'lat': 0, 'long': 0},
          {'lat': 0, 'long': 0},
          {'lat': 0, 'long': 0}
        ]);

  void addLocationAtIndex(int index, Map values) {
    state[index] = values;
    state = [...state];
  }

  void addLocation(Map values) {
    state = [...state, values];
  }

  void setList(List list) {
    state = [...list];
  }

  void removeLocation(int index) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = state.removeAt(index);
  }

  void clearList() {
    state = [
      {'lat': 0, 'long': 0},
      {'lat': 0, 'long': 0},
      {'lat': 0, 'long': 0},
      {'lat': 0, 'long': 0}
    ];
  }

  Map getLocation(int index) {
    return state[index];
  }
}
