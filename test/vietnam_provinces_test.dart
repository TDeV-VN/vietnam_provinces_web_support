import 'package:flutter_test/flutter_test.dart';
import 'package:vietnam_provinces/vietnam_provinces.dart';

void main() {
  group('VietnamProvinces Tests', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await VietnamProvinces.initialize();
    });

    test('Get provinces by name query', () {
      final results = VietnamProvinces.getProvinces(query: 'Hà Nội');
      expect(results.isNotEmpty, true);
      expect(results.first.name, contains('Hà Nội'));
    });

    test('Get districts by province code', () {
      final districts = VietnamProvinces.getDistricts(provinceCode: 1);
      expect(districts.isNotEmpty, true);
    });

    test('Get wards by district code', () {
      final wards = VietnamProvinces.getWards(provinceCode: 1, districtCode: 5);
      expect(wards.isNotEmpty, true);
    });
  });
}
