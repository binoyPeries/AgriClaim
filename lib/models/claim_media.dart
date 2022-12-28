import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'claim_media.g.dart';

@JsonSerializable()
class ClaimMedia {
  final String mediaUrl;
  final double latitude;
  final double longitude;
  final bool accepted;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime capturedDateTime;
  static toNull(_) => null;
  @JsonKey(toJson: toNull, fromJson: toNull, includeIfNull: false)
  final XFile mediaFile;

  ClaimMedia(
    this.mediaFile,
    this.mediaUrl,
    this.latitude,
    this.longitude,
    this.accepted,
    this.capturedDateTime,
  );

  factory ClaimMedia.fromJson(Map<String, dynamic> json) =>
      _$ClaimMediaFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimMediaToJson(this);

  static final _dateFormatter = DateFormat('dd-MM-yyyy hh:mm a');
  static DateTime _fromJson(String date) => _dateFormatter.parse(date);
  static String _toJson(DateTime date) => _dateFormatter.format(date);
}
