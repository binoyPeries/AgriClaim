// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'officer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Officer _$OfficerFromJson(Map<String, dynamic> json) => Officer(
      json['officerId'] as String,
      json['officerRegNo'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$OfficerToJson(Officer instance) => <String, dynamic>{
      'officerId': instance.officerId,
      'officerRegNo': instance.officerRegNo,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
    };
