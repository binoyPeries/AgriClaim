import 'package:json_annotation/json_annotation.dart';

part 'officer.g.dart';

@JsonSerializable()
class Officer {
  final String officerId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String officerRegNo;
  // this is to make sure that docID will not be in  the toJson method
  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String docId;

  Officer(
    this.officerId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.docId,
    this.officerRegNo,
  );

  factory Officer.fromJson(Map<String, dynamic> json) =>
      _$OfficerFromJson(json);

  Map<String, dynamic> toJson() => _$OfficerToJson(this);
}
