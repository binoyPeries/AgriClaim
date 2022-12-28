// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimMedia _$ClaimMediaFromJson(Map<String, dynamic> json) => ClaimMedia(
      ClaimMedia.toNull(json['mediaFile']),
      json['mediaUrl'] as String,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      json['accepted'] as bool,
      ClaimMedia._fromJson(json['capturedDateTime'] as String),
    );

Map<String, dynamic> _$ClaimMediaToJson(ClaimMedia instance) {
  final val = <String, dynamic>{
    'mediaUrl': instance.mediaUrl,
    'latitude': instance.latitude,
    'longitude': instance.longitude,
    'accepted': instance.accepted,
    'capturedDateTime': ClaimMedia._toJson(instance.capturedDateTime),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mediaFile', ClaimMedia.toNull(instance.mediaFile));
  return val;
}
