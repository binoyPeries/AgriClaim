import 'package:json_annotation/json_annotation.dart';

part 'farmer.g.dart';

@JsonSerializable()
class Farmer {
  final String uid;
  final String firstName;
  final String lastName;
  final String nic;
  final String homeAddress;

  Farmer({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.nic,
    required this.homeAddress,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) => _$FarmerFromJson(json);

  Map<String, dynamic> toJson() => _$FarmerToJson(this);
}
