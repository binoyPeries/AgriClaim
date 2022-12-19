import 'package:json_annotation/json_annotation.dart';

part 'officer.g.dart';

@JsonSerializable()
class Officer {
  final String officerId;
  final String officerRegNo;
  final String firstName;
  final String lastName;
  final String email;

  Officer(
    this.officerId,
    this.officerRegNo,
    this.firstName,
    this.lastName,
    this.email,
  );

  factory Officer.fromJson(Map<String, dynamic> json) =>
      _$OfficerFromJson(json);

  Map<String, dynamic> toJson() => _$OfficerToJson(this);
}
