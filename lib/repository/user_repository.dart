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
