// import 'dart:io';
//
// import 'package:image_picker/image_picker.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'claim_form.g.dart';
//
// @JsonSerializable()
// class ClaimForm {
//   final String claimReference;
//   final String farmId;
//   final List<File> claimPhotos;
//   final File claimVideo;
//   final String? farmerNote;
//
//   ClaimForm(
//     this.claimReference,
//     this.farmId,
//     this.claimPhotos,
//     this.claimVideo,
//     this.farmerNote,
//   );
//
//   factory ClaimForm.fromJson(Map<String, dynamic> json) =>
//       _$ClaimFormFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ClaimFormToJson(this);
//
//   static _toJson() {}
//
//   static _fromJson() {}
// }
