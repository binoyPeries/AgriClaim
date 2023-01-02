import 'package:json_annotation/json_annotation.dart';

part 'farm.g.dart';

@JsonSerializable()
class Farm {
  late final String id;
  final String ownerId;
  final String farmAddress;
  String farmName;
  late final List<Map<String, double>> locations;

  Farm({
    required this.ownerId,
    required this.id,
    required this.farmAddress,
    required this.farmName,
    required this.locations,
  });
  // command - flutter pub run build_runner build --delete-conflicting-outputs
  factory Farm.fromJson(Map<String, dynamic> json) => _$FarmFromJson(json);

  Map<String, dynamic> toJson() => _$FarmToJson(this);

  Farm copyWith(
    String? id,
    String? ownerId,
    String? farmAddress,
    String? farmName,
    List<Map<String, double>>? locations,
  ) {
    return Farm(
        ownerId: ownerId ?? this.ownerId,
        id: id ?? this.id,
        farmAddress: farmAddress ?? this.farmAddress,
        farmName: farmName ?? this.farmName,
        locations: locations ?? this.locations);
  }
}
