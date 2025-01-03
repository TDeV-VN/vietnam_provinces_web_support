import 'package:vietnam_provinces/src/models/ward.dart';

/// Represents a district within a province.
class District {
  /// The unique code of the district.
  final int code;

  /// The name of the district.
  final String name;

  /// The list of wards within the district.
  final List<Ward> wards;

  /// Creates a new [District] instance.
  District({required this.code, required this.name, required this.wards});

  /// Creates a new [District] instance from a JSON object.
  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      code: json['code'],
      name: json['name'],
      wards:
          (json['wards'] as List).map((ward) => Ward.fromJson(ward)).toList(),
    );
  }
}
