import 'package:json_annotation/json_annotation.dart';

part 'farm.g.dart';

@JsonSerializable()
class Farm {
  final String uId;
  final String ownerId;
  final String farmAddress;
  final String farmName;
  final List<Map<String, int>> locations;

  Farm({
    required this.ownerId,
    required this.uId,
    required this.farmAddress,
    required this.farmName,
    required this.locations,
  });
  // command - flutter pub run build_runner build --delete-conflicting-outputs
  factory Farm.fromJson(Map<String, dynamic> json) => _$FarmFromJson(json);

  Map<String, dynamic> toJson() => _$FarmToJson(this);
}
