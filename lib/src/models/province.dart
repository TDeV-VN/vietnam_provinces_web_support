import 'package:vietnam_provinces/src/models/district.dart';

class Province {
  final int code;
  final String name;
  final List<District> districts;

  Province({required this.code, required this.name, required this.districts});

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
