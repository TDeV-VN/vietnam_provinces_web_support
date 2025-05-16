import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'models/province.dart';

class ProvinceHelper {
  static const String _filePath =
      'packages/vietnam_provinces/lib/assets/provinces.json.gz';

  static Future<List<Province>> loadProvinces() async {
    try {
      final ByteData compressedData = await rootBundle.load(_filePath);
      final List<int> gzippedBytes = compressedData.buffer.asUint8List();
      final List<int> decompressedBytes = GZipDecoder().decodeBytes(
        gzippedBytes,
        verify: true,
      );
      final String jsonDataString = utf8.decode(decompressedBytes);
      final List<dynamic> jsonList =
          jsonDecode(jsonDataString) as List<dynamic>;
      return jsonList
          .map((json) => Province.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading provinces: $e');
      throw Exception('Failed to load provinces: $e');
    }
  }
}
