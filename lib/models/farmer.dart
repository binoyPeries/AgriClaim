import 'package:json_annotation/json_annotation.dart';

part 'farmer.g.dart';

@JsonSerializable()
class Farmer {
  final String phoneNumber;
  final String farmerId;
  final String firstName;
  final String lastName;
  final String nic;
  final String homeAddress;
  final String? accNumber;
  final String? bank;
  final String? bankBranch;
  final String? accHolderName;

  Farmer({
    required this.farmerId,
    required this.firstName,
    required this.lastName,
    required this.nic,
    required this.homeAddress,
    required this.phoneNumber,
    this.accNumber,
    this.bank,
    this.bankBranch,
    this.accHolderName,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) => _$FarmerFromJson(json);

  Map<String, dynamic> toJson() => _$FarmerToJson(this);
}
