// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Claim _$ClaimFromJson(Map<String, dynamic> json) => Claim(
      json['claimId'] as String,
      json['claimReference'] as String,
      json['farmerId'] as String,
      json['farmId'] as String,
      json['farmerNote'] as String?,
      (json['claimPhotos'] as List<dynamic>)
          .map((e) => ClaimMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['claimVideo'] == null
          ? null
          : ClaimMedia.fromJson(json['claimVideo'] as Map<String, dynamic>),
      (json['compensation'] as num).toDouble(),
      json['officerNote'] as String?,
      json['status'] as String,
      json['assignedOfficer'] as String?,
      Claim._fromJson(json['claimDate'] as String),
      json['approved'] as bool?,
    );

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'claimId': instance.claimId,
      'claimReference': instance.claimReference,
      'farmerId': instance.farmerId,
      'farmId': instance.farmId,
      'farmerNote': instance.farmerNote,
      'approved': instance.approved,
      'claimPhotos': instance.claimPhotos,
      'claimVideo': instance.claimVideo,
      'compensation': instance.compensation,
      'officerNote': instance.officerNote,
      'status': instance.status,
      'assignedOfficer': instance.assignedOfficer,
      'claimDate': Claim._toJson(instance.claimDate),
    };
