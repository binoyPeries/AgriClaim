import 'package:flutter_riverpod/flutter_riverpod.dart';

final claimSelectedFarmLocationsNotifierProvider = StateNotifierProvider<
    ClaimSelectedFarmLocationsNotifier, List<Map<String, double>>>((ref) {
  return ClaimSelectedFarmLocationsNotifier();
});

class ClaimSelectedFarmLocationsNotifier
    extends StateNotifier<List<Map<String, double>>> {
  ClaimSelectedFarmLocationsNotifier() : super([]);

  void setFarmLocations(List<Map<String, double>> farmLocations) {
    // state = farm.copyWith(null, null, null, null, null);
    state = [...farmLocations];
  }
}
