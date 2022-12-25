import 'package:agriclaim/models/farmer.dart';
import 'package:agriclaim/repository/auth_repository.dart';
import 'package:agriclaim/ui/constants/database.dart';
import 'package:agriclaim/utils/agriclaim_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/officer.dart';

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
        final data = {
          "docId": element.id,
          "phoneNumber": phoneNumber,
          ...element.data()
        };
        Farmer farmer = Farmer.fromJson(data);
        return farmer;
      }).toList();
      return result.isNotEmpty ? result[0] : null;
    });
    return farmer;
  }

  Future<bool> updateLoggedInFarmerProfile(
      String docId, Map<String, dynamic> data) async {
    try {
      await _store.collection(DatabaseNames.officer).doc(docId).update(data);
      return true;
    } on FirebaseException catch (e) {
      throw AgriclaimException(e.message ?? "Failed to update profile");
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

  Stream<Officer?> getLoggedInOfficerDetails(String phoneNumber) {
    final officer = _store
        .collection(DatabaseNames.officer)
        .where('uid', isEqualTo: loggedUserId)
        .snapshots()
        .map((event) {
      final result = event.docs.map((element) {
        final data = {
          "docId": element.id,
          "phoneNumber": phoneNumber,
          "officerId": loggedUserId,
          ...element.data()
        };
        Officer officer = Officer.fromJson(data);
        print(officer);
        print("=====================");
        return officer;
      }).toList();
      return result.isNotEmpty ? result[0] : null;
    });
    return officer;
  }

  Future<bool> updateLoggedInOfficerProfile(
      String docId, Map<String, dynamic> data) async {
    try {
      await _store.collection(DatabaseNames.officer).doc(docId).update(data);
      return true;
    } on FirebaseException catch (e) {
      throw AgriclaimException(e.message ?? "Failed to update profile");
    }
  }
}
