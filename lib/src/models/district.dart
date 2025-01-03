import 'package:vietnam_provinces/src/models/ward.dart';

class District {
  final int code;
  final String name;
  final List<Ward> wards;

  District({required this.code, required this.name, required this.wards});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      code: json['code'],
      name: json['name'],
      wards:
          (json['wards'] as List).map((ward) => Ward.fromJson(ward)).toList(),
    );
  }
}
