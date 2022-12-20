import 'package:agriclaim/models/farm.dart';
import 'package:agriclaim/repository/farm_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

final farmRepositoryProvider = Provider<FarmRepository>((ref) {
  final currentUser = ref.watch(authRepositoryProvider).getLoggedInUser();
  return FarmRepository(FirebaseFirestore.instance, currentUser?.uid);
});

/// Editable toggle for editing farm information
final farmEditableStateProvider = StateProvider<bool>((ref) {
  return false;
});

/// Provider that returns the stream of changes in the farm documents where the owner ID is the logged in user's ID
final farmListProvider = StreamProvider.autoDispose<List<Farm>>((ref) {
  final farmRepository = ref.watch(farmRepositoryProvider);
  final farmsList = farmRepository.getLoggedInUserFarms();
  return farmsList;
});

///  Farm locations update for creating a new farm
final farmLocationCountStateProvider =
    StateNotifierProvider<FarmLocationsNotifier, List>((ref) {
  return FarmLocationsNotifier();
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

/// Farm notifier - for viewing and updating registered farm information

final farmNotifierProvider =
    StateNotifierProvider.family<FarmNotifier, Farm, Farm>((ref, farm) {
  return FarmNotifier(farm);
});

class FarmNotifier extends StateNotifier<Farm> {
  final Farm farm;
  FarmNotifier(this.farm) : super(farm);

  void updateLocation(Map<String, double> location, int index) {
    List<Map<String, double>> locations = [...state.locations];
    locations[index] = location;
    state = farm.copyWith(null, null, null, null, locations);
  }
}
