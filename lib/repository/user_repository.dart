import 'package:agriclaim/models/farmer.dart';
import 'package:agriclaim/repository/auth_repository.dart';
import 'package:agriclaim/ui/constants/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _store;
  final String? loggedUserId;

  UserRepository(this._store, this.loggedUserId);

  Future<DocumentReference<Map<String, dynamic>>> addFarmer(
      Map<String, dynamic> userData) async {
    Map<String, dynamic> data = {"farmerId": loggedUserId, ...userData};
    try {
      final result = await _store.collection(DatabaseNames.farmer).add(data);
      return result;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Stream<Farmer?> getLoggedInFarmerDetails(String phoneNumber) {
    final farmer = _store
        .collection(DatabaseNames.farmer)
        .where('farmerId', isEqualTo: loggedUserId)
        .snapshots()
        .map((event) {
      final result = event.docs.map((element) {
        final data = {"phoneNumber": phoneNumber, ...element.data()};
        Farmer farmer = Farmer.fromJson(data);
        return farmer;
      }).toList();
      return result.isNotEmpty ? result[0] : null;
    });
    return farmer;
  }

  Future<DocumentReference<Map<String, dynamic>>> addOfficer(
      Map<String, dynamic> userData) async {
    Map<String, dynamic> data = {"uid": loggedUserId, ...userData};
    try {
      final result = await _store.collection(DatabaseNames.officer).add(data);
      return result;
    } catch (e) {
      throw throw AuthException(e.toString());
    }
  }
}
