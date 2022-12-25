// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'officer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Officer _$OfficerFromJson(Map<String, dynamic> json) => Officer(
      json['officerId'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['phoneNumber'] as String,
      json['docId'] as String,
    );

Map<String, dynamic> _$OfficerToJson(Officer instance) {
  final val = <String, dynamic>{
    'officerId': instance.officerId,
    'firstName': instance.firstName,
    'lastName': instance.lastName,
    'email': instance.email,
    'phoneNumber': instance.phoneNumber,
    'docId': instance.docId,
  };
  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('docId', Officer.toNull(instance.docId));
  return val;
}
