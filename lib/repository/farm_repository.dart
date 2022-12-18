import 'package:agriclaim/ui/constants/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../ui/common/utils/agriclaim_exception.dart';

class FarmRepository {
  final FirebaseFirestore _store;
  final String? loggedUserId;

  FarmRepository(this._store, this.loggedUserId);

  Future<DocumentReference<Map<String, dynamic>>> addFarm(
      Map<String, dynamic> farmData) async {
    Map<String, dynamic> data = {"uid": loggedUserId, ...farmData};
    try {
      final result = await _store.collection(DatabaseNames.farm).add(data);
      return result;
    } catch (e) {
      throw FarmException(e.toString());
    }
  }
}

class FarmException implements AgriclaimException {
  final String message;

  FarmException(this.message);

  @override
  String get errorMsg => message;
}
