import 'dart:io';

import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/ui/constants/database.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:agriclaim/utils/agriclaim_exception.dart';
import 'package:agriclaim/utils/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

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

  Future<String> _uploadVideo(XFile video) async {
    final storageRef = _storage.ref();
    final claimPhotosRef = storageRef.child("claims/videos");

    final fileName = video.name;
    try {
      // compress the video
      final compressedVideo = await VideoCompress.compressVideo(
        video.path,
        quality: VideoQuality.LowQuality,
        includeAudio: false,
      );
      final snapshot = await claimPhotosRef
          .child(fileName)
          .putFile(File(compressedVideo?.path ?? ""));
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      //:TODO check later
      throw AgriclaimException(e.message ?? "");
    }
  }

  Future<bool> createClaim(
      {required Map<String, dynamic> mediaData,
      required Map<String, dynamic> data}) async {
    final List<XFile> photoList = mediaData['claimPhotos'];

    Map<String, dynamic> finalDataMap = {...data};

    final XFile? video = mediaData['claimVideo'];
    final imageUrlList = await _uploadImage(photoList);

    finalDataMap["claimPhotos"] = imageUrlList;

    if (video != null) {
      final uploadedVideo = await _uploadVideo(video);
      finalDataMap["claimVideo"] = uploadedVideo;
    }
    finalDataMap["farmerId"] = loggedUserId;
    finalDataMap["status"] = ClaimStates.pending.name;
    finalDataMap["compensation"] = 0.0;
    finalDataMap["assignedOfficer"] = null;
    finalDataMap["officerNote"] = null;
    finalDataMap["claimDate"] = getCurrentDate();

    try {
      await _store.collection(DatabaseNames.claim).add(finalDataMap);
      return true;
    } catch (e) {
      throw AgriclaimException(e.toString());
    }
  }

  Stream<List<Claim>> getClaimsList(ClaimStates claimType) {
    final claimList = _store
        .collection(DatabaseNames.claim)
        .where('farmerId', isEqualTo: loggedUserId)
        .where('status', isEqualTo: claimType.name)
        .snapshots()
        .map((event) {
      final result = event.docs.map((element) {
        final data = {"claimId": element.id, ...element.data()};
        Claim farm = Claim.fromJson(data);
        return farm;
      }).toList();
      return result;
    });
    return claimList;
  }
}
