# Vietnam Provinces

[![Pub](https://img.shields.io/pub/v/vietnam_provinces.svg)](https://pub.dev/packages/vietnam_provinces)

A Flutter package for managing Vietnam's administrative divisions: provinces, districts, and wards.

## 📄 Data source

The data for this package is sourced from the [Vietnam Provinces Open API](https://provinces.open-api.vn)

## ✨ Features

- Retrieve provinces, districts, and wards.
- Search by name (query) or code.
- Lightweight and simple to integrate.

## 🚀 Getting Started

1. Add the package to your `pubspec.yaml`:

   ```yaml
   dependencies:
     vietnam_provinces: ^1.0.0
   ```

2. Load the data in your app:

   ```dart
   import 'package:vietnam_provinces/vietnam_provinces.dart';

   void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await VietnamProvinces.initialize();
   }
   ```

## 🔧 Usage

- **Get provinces or query:**

  ```dart
  final provinces = VietnamProvinces.getProvinces(code: 1);
  ```

  ```dart
  final provinces = VietnamProvinces.getProvinces(query: "Hà");
  ```

- **Get districts by province code, and query:**

  ```dart
  final districts = VietnamProvinces.getDistricts(
    provinceCode: 1,
    query: "Quận",
  );
  ```

- **Get wards by provinceCode, districtCode, and query:**

  ```dart
  final wards = VietnamProvinces.getWards(
    provinceCode: 1,
    districtCode: 10,
    query: "Phường",
  );
  ```

## 📱 Example

To see `vietnam_provinces` in action, check out the example project in the [example](https://github.com/14h4i/vietnam_provinces/blob/master/example/lib/main.dart).

## 🛠️ Contributions

We welcome contributions! If you have ideas for features, bug fixes, or improvements, feel free to open an issue or submit a pull request.

## 🐞 Issues and feedback

Please file [issues](https://github.com/14h4i/vietnam_provinces/issues) to send feedback or report a bug. Thank you!

## 📜 License

[MIT](https://mit-license.org) License

<a href="https://www.buymeacoffee.com/14h4i" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
