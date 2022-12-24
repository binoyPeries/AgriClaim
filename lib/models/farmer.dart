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
  final String? accountNumber;
  final String? bank;
  final String? bankBranch;
  final String? accountHolderName;
  // this is to make sure that docID will not be in  the toJson method
  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String docId;

  Farmer({
    required this.farmerId,
    required this.firstName,
    required this.lastName,
    required this.nic,
    required this.homeAddress,
    required this.phoneNumber,
    this.accountNumber,
    this.bank,
    this.bankBranch,
    this.accountHolderName,
    required this.docId,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) => _$FarmerFromJson(json);

  Map<String, dynamic> toJson() => _$FarmerToJson(this);
}
