import 'dart:io';

import 'package:agriclaim/ui/common/utils/agriclaim_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ClaimRepository {
  final FirebaseFirestore _store;
  final FirebaseStorage _storage;
  final String? loggedUserId;

  ClaimRepository(this._store, this._storage, this.loggedUserId);

  Future<List<String>> _uploadImage(List<XFile> images) async {
    final storageRef = _storage.ref();
    final claimPhotosRef = storageRef.child("claims/images");
    List<String> imageUrls = [];
    for (final item in images) {
      final fileName = item.name;
      try {
        final snapshot =
            await claimPhotosRef.child(fileName).putFile(File(item.path));
        final downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      } on FirebaseException catch (e) {
        //:TODO check later
        throw AgriclaimException(e.message ?? "");
      }
    }
    return imageUrls;
  }

  Future<void> createClaim(
      {required Map<String, dynamic> mediaData,
      required Map<String, dynamic> data}) async {
    final List<XFile> photoList = mediaData['claimPhotos'];
    final XFile video = mediaData['claimVideo'];
    final imageUrlList = await _uploadImage(photoList);
    //:TODO start from here add videos as well
  }
}
