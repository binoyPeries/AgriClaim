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
  );
  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);
}
