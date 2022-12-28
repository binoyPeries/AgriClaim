import 'dart:io';

import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/models/claim_media.dart';
import 'package:agriclaim/ui/constants/database.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:agriclaim/utils/agriclaim_exception.dart';
import 'package:agriclaim/utils/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_compress/video_compress.dart';

class ClaimRepository {
  final FirebaseFirestore _store;
  final FirebaseStorage _storage;
  final String? loggedUserId;

  ClaimRepository(this._store, this._storage, this.loggedUserId);

  Future<List<ClaimMedia>> _uploadImage(List<ClaimMedia> images) async {
    final storageRef = _storage.ref();
    final claimPhotosRef = storageRef.child("claims/images");
    List<ClaimMedia> imageUrls = [];
    for (final item in images) {
      final imageFile = item.mediaFile;
      final fileName = imageFile.name;
      try {
        final snapshot =
            await claimPhotosRef.child(fileName).putFile(File(imageFile.path));
        final downloadUrl = await snapshot.ref.getDownloadURL();
        // to add the image url to existing ClaimMedia object
        final result = item.clone(mediaUrl: downloadUrl);
        imageUrls.add(result);
      } on FirebaseException catch (e) {
        //:TODO check later
        throw AgriclaimException(e.message ?? "");
      }
    }
    return imageUrls;
  }

  Future<ClaimMedia> _uploadVideo(ClaimMedia video) async {
    final storageRef = _storage.ref();
    final claimPhotosRef = storageRef.child("claims/videos");
    final videoFile = video.mediaFile;
    final fileName = videoFile.name;
    try {
      // compress the video
      final compressedVideo = await VideoCompress.compressVideo(
        videoFile.path,
        quality: VideoQuality.LowQuality,
        includeAudio: false,
      );
      final snapshot = await claimPhotosRef
          .child(fileName)
          .putFile(File(compressedVideo?.path ?? ""));
      final downloadUrl = await snapshot.ref.getDownloadURL();
      // to add the video url to existing ClaimMedia object
      final result = video.clone(mediaUrl: downloadUrl);
      return result;
    } on FirebaseException catch (e) {
      //:TODO check later
      throw AgriclaimException(e.message ?? "");
    }
  }

  Future<bool> createClaim(
      {required Map<String, dynamic> mediaData,
      required Map<String, dynamic> data}) async {
    final List<ClaimMedia> photoList = mediaData['claimPhotos'];

    Map<String, dynamic> finalDataMap = {...data};

    final ClaimMedia? video = mediaData['claimVideo'];
    final imageUrlList = await _uploadImage(photoList);

    // convert the list of objects to a list of maps
    List<Map<String, dynamic>> images = [];
    for (var element in imageUrlList) {
      images.add(element.toJson());
    }
    finalDataMap["claimPhotos"] = images;

    if (video != null) {
      final uploadedVideo = await _uploadVideo(video);
      finalDataMap["claimVideo"] = uploadedVideo.toJson();
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

  Future<bool> updateClaim(
      {required Map<String, dynamic> data,
      required String claimId,
      required bool accepted}) async {
    try {
      await _store.doc("${DatabaseNames.claim}/$claimId").update({
        'compensation': double.parse(data["compensation"]),
        'officerNote': data["officerNote"],
        'approved': accepted,
        'status': "Completed",
      });
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

  Stream<List<Claim>> searchClaimsList(String claimId) {
    final claimList = _store
        .collection(DatabaseNames.claim)
        .where('assignedOfficer', isEqualTo: loggedUserId)
        .snapshots()
        .map((event) {
      final result = event.docs.map((element) {
        final data = {"claimId": element.id, ...element.data()};
        Claim claim = Claim.fromJson(data);
        return claim;
      }).toList();
      return result
          .where((element) => element.claimId.startsWith(claimId))
          .toList();
    });
    return claimList;
  }

  Stream<List<Claim>> getClaimsListForOfficer(ClaimStates claimType) {
    final claimList = _store
        .collection(DatabaseNames.claim)
        .where('assignedOfficer', isEqualTo: loggedUserId)
        .where('status', isEqualTo: claimType.name)
        .snapshots()
        .map((event) {
      final result = event.docs.map((element) {
        final data = {"claimId": element.id, ...element.data()};
        Claim claim = Claim.fromJson(data);
        return claim;
      }).toList();
      return result;
    });
    return claimList;
  }
}
