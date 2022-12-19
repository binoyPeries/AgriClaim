import 'package:agriclaim/ui/constants/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/farm.dart';
import '../ui/common/utils/agriclaim_exception.dart';

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
        return Farm.fromJson(element.data());
      }).toList();
      return result;
    });
    return farmList;
  }
}

class FarmException implements AgriclaimException {
  final String message;

  FarmException(this.message);

  @override
  String get errorMsg => message;
}
