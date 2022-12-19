// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Farm _$FarmFromJson(Map<String, dynamic> json) => Farm(
      ownerId: json['ownerId'] as String,
      id: json['id'] as String,
      farmAddress: json['farmAddress'] as String,
      farmName: json['farmName'] as String,
      locations: (json['locations'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ))
          .toList(),
    );

Map<String, dynamic> _$FarmToJson(Farm instance) => <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'farmAddress': instance.farmAddress,
      'farmName': instance.farmName,
      'locations': instance.locations,
    };
