// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Farmer _$FarmerFromJson(Map<String, dynamic> json) => Farmer(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      nic: json['nic'] as String,
      homeAddress: json['homeAddress'] as String,
    );

Map<String, dynamic> _$FarmerToJson(Farmer instance) => <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'nic': instance.nic,
      'homeAddress': instance.homeAddress,
    };
