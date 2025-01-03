library vietnam_provinces;

import 'models/district.dart';
import 'models/province.dart';
import 'models/ward.dart';
import 'province_helper.dart';
import 'utils.dart';

/// A library for managing Vietnamese provinces, districts, and wards.
class VietnamProvinces {
  static late List<Province> _provinces;

  /// Initializes the plugin by loading province data.
  static Future<void> initialize() async {
    _provinces = await ProvinceHelper.loadProvinces();
  }

  /// Gets the list of provinces.
  ///
  /// Optionally filters by [code] or [query].
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

  /// Gets the list of districts by province code.
  ///
  /// Optionally filters by [query].
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

  /// Gets the list of wards by province code and district code.
  ///
  /// Optionally filters by [query].
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
