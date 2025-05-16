import 'dart:convert';
import 'package:archive/archive.dart';

import 'package:flutter/services.dart';

import 'models/province.dart';

/// Helper class for loading province data.
class ProvinceHelper {
  static const String _filePath =
      'packages/vietnam_provinces/lib/assets/provinces.json.gz';

  /// Loads the list of provinces from a compressed JSON file.
  static Future<List<Province>> loadProvinces() async {
    try {
      final compressedData = await rootBundle.load(_filePath);
      // final jsonData =
      //     utf8.decode(gzip.decode(compressedData.buffer.asUint8List()));
      final List<int> gzippedBytes = bytes.buffer.asUint8List();
      final List<int> decompressedBytes = GZipDecoder().decodeBytes(
        gzippedBytes,
        verify: true,
      ); // Sử dụng GZipDecoder từ package archive
      final jsonData = utf8.decode(decompressedBytes);
      final List<dynamic> jsonList = jsonDecode(jsonData);

      return jsonList.map((json) => Province.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error loading provinces: $e');
    }
  }
}
