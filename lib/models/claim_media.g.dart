// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimMedia _$ClaimMediaFromJson(Map<String, dynamic> json) => ClaimMedia(
      mediaFile: ClaimMedia.toNull(json['mediaFile']),
      mediaUrl: json['mediaUrl'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accepted: json['accepted'] as bool,
      capturedDateTime:
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
