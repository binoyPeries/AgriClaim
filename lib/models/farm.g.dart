// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Farm _$FarmFromJson(Map<String, dynamic> json) => Farm(
      ownerId: json['ownerId'] as String,
      uId: json['uId'] as String,
      farmAddress: json['farmAddress'] as String,
      farmName: json['farmName'] as String,
      locations: (json['locations'] as List<dynamic>)
          .map((e) => Map<String, int>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$FarmToJson(Farm instance) => <String, dynamic>{
      'uId': instance.uId,
      'ownerId': instance.ownerId,
      'farmAddress': instance.farmAddress,
      'farmName': instance.farmName,
      'locations': instance.locations,
    };
