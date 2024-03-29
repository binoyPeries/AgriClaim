import 'package:agriclaim/ui/constants/database.dart';
import 'package:agriclaim/utils/agriclaim_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/farm.dart';

class FarmRepository {
  final FirebaseFirestore _store;
  final String? loggedUserId;

  FarmRepository(this._store, this.loggedUserId);

  Future<DocumentReference<Map<String, dynamic>>> addFarm(
      Map<String, dynamic> farmData) async {
    Map<String, dynamic> data = {"ownerId": loggedUserId, ...farmData};
    try {
      final result = await _store.collection(DatabaseNames.farm).add(data);
      return result;
    } catch (e) {
      throw FarmException(e.toString());
    }
  }

  Stream<List<Farm>> getLoggedInUserFarms() {
    final farmList = _store
        .collection(DatabaseNames.farm)
        .where('ownerId', isEqualTo: loggedUserId)
        .snapshots()
        .map((event) {
      final result = event.docs.map((element) {
        final data = {"id": element.id, ...element.data()};
        Farm farm = Farm.fromJson(data);
        return farm;
      }).toList();
      return result;
    });
    return farmList;
  }

  Future<Farm> getFarm(String farmId) {
    final docSnapshot = _store.doc("${DatabaseNames.farm}/$farmId");
    final farm = docSnapshot.get().then((value) {
      final data = {"id": value.id, ...?value.data()};
      final farm = Farm.fromJson(data);
      return farm;
    });
    return farm;
  }

  Future<bool> updateFarm(Farm farm) async {
    try {
      await _store.doc("${DatabaseNames.farm}/${farm.id}").update({
        'ownerId': farm.ownerId,
        'farmAddress': farm.farmAddress,
        'farmName': farm.farmName,
        'locations': farm.locations
      });
      return true;
    } catch (e) {
      return Future.error(e); //return error
    }
  }
}

class FarmException implements AgriclaimException {
  final String message;

  FarmException(this.message);

  @override
  String get errorMsg => message;
}
