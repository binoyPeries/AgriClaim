// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Farmer _$FarmerFromJson(Map<String, dynamic> json) => Farmer(
      farmerId: json['farmerId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      nic: json['nic'] as String,
      homeAddress: json['homeAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
      accountNumber: json['accountNumber'] as String?,
      bank: json['bank'] as String?,
      bankBranch: json['bankBranch'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      docId: json['docId'] as String,
    );

Map<String, dynamic> _$FarmerToJson(Farmer instance) {
  final val = <String, dynamic>{
    'phoneNumber': instance.phoneNumber,
    'farmerId': instance.farmerId,
    'firstName': instance.firstName,
    'lastName': instance.lastName,
    'nic': instance.nic,
    'homeAddress': instance.homeAddress,
    'accountNumber': instance.accountNumber,
    'bank': instance.bank,
    'bankBranch': instance.bankBranch,
    'accountHolderName': instance.accountHolderName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('docId', Farmer.toNull(instance.docId));
  return val;
}
