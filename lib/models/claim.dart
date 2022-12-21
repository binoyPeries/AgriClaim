import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'claim.g.dart';

@JsonSerializable()
class Claim {
  final String claimId;
  final String claimReference;
  final String farmerId;
  final String farmId;
  final String? farmerNote;
  final List<String> claimPhotos;
  final String? claimVideo;
  final double compensation;
  final String? officerNote;
  final String status;
  final String? assignedOfficer;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime claimDate;

  Claim(
    this.claimId,
    this.claimReference,
    this.farmerId,
    this.farmId,
    this.farmerNote,
    this.claimPhotos,
    this.claimVideo,
    this.compensation,
    this.officerNote,
    this.status,
    this.assignedOfficer,
    this.claimDate,
  );
  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);

  static final _dateFormatter = DateFormat('dd-MM-yyyy');
  static DateTime _fromJson(String date) => _dateFormatter.parse(date);
  static String _toJson(DateTime date) => _dateFormatter.format(date);
}
