library vietnam_provinces;

import 'models/district.dart';
import 'models/province.dart';
import 'models/ward.dart';
import 'province_helper.dart';
import 'utils.dart';

class VietnamProvinces {
  static late List<Province> _provinces;

  // Initialize plugin
  static Future<void> initialize() async {
    _provinces = await ProvinceHelper.loadProvinces();
  }

  // Get list of provinces
  static List<Province> getProvinces({int? code, String? query}) {
    return _provinces.where((province) {
      final matchesCode = code == null || province.code == code;

      final normalizedQuery = query != null ? removeDiacritics(query) : null;
      final normalizedProvinceName = removeDiacritics(province.name);

      final matchesQuery = normalizedQuery == null ||
          normalizedProvinceName.contains(normalizedQuery);
      return matchesCode && matchesQuery;
    }).toList();
  }

  // Get list of districts by province code
  static List<District> getDistricts(
      {required int provinceCode, String? query}) {
    final province = _provinces.firstWhere(
      (p) => p.code == provinceCode,
      orElse: () =>
          throw ArgumentError('Province with code $provinceCode not found'),
    );

    return province.districts.where((district) {
      final normalizedQuery = query != null ? removeDiacritics(query) : null;
      final normalizedDistrictName = removeDiacritics(district.name);

      final matchesQuery = normalizedQuery == null ||
          normalizedDistrictName.contains(normalizedQuery);
      return matchesQuery;
    }).toList();
  }

  // Get list of wards by province code and district code
  static List<Ward> getWards(
      {required int provinceCode, required int districtCode, String? query}) {
    final province = _provinces.firstWhere(
      (p) => p.code == provinceCode,
      orElse: () =>
          throw ArgumentError('Province with code $provinceCode not found'),
    );

    final district = province.districts.firstWhere(
      (d) => d.code == districtCode,
      orElse: () =>
          throw ArgumentError('District with code $districtCode not found'),
    );

    return district.wards.where((ward) {
      final normalizedQuery = query != null ? removeDiacritics(query) : null;
      final normalizedWardName = removeDiacritics(ward.name);

      final matchesQuery = normalizedQuery == null ||
          normalizedWardName.contains(normalizedQuery);
      return matchesQuery;
    }).toList();
  }
}
