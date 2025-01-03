import 'dart:convert';

import 'package:flutter/services.dart';

import 'models/province.dart';

class ProvinceHelper {
  static Future<List<Province>> loadProvinces() async {
    final data = await rootBundle
        .loadString('packages/vietnam_provinces/lib/assets/provinces.json');
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => Province.fromJson(json)).toList();
  }
}
