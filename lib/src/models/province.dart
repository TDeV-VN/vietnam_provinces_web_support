import 'package:vietnam_provinces/src/models/district.dart';

/// Represents a province.
class Province {
  /// The unique code of the province.
  final int code;

  /// The name of the province.
  final String name;

  /// The list of districts within the province.
  final List<District> districts;

  /// Creates a new [Province] instance.
  Province({required this.code, required this.name, required this.districts});

  /// Creates a new [Province] instance from a JSON object.
  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      code: json['code'],
      name: json['name'],
      districts: (json['districts'] as List)
          .map((district) => District.fromJson(district))
          .toList(),
    );
  }
}
