import 'package:flutter/material.dart';
import 'package:vietnam_provinces/vietnam_provinces.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await VietnamProvinces.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vietnam Provinces Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;

  List<Province> filteredProvinces = [];
  List<District> filteredDistricts = [];
  List<Ward> filteredWards = [];

  @override
  void initState() {
    super.initState();
    filteredProvinces = VietnamProvinces.getProvinces();
  }

  void updateFilteredProvinces(String query) {
    selectedProvince = null;
    selectedDistrict = null;
    selectedWard = null;
    filteredWards = [];
    filteredDistricts = [];
    setState(() {
      filteredProvinces = VietnamProvinces.getProvinces(query: query);
    });
  }

  void updateFilteredDistricts(String query) {
    selectedDistrict = null;
    selectedWard = null;
    filteredWards = [];
    if (selectedProvince != null) {
      setState(() {
        filteredDistricts = VietnamProvinces.getDistricts(
          provinceCode: selectedProvince!.code,
          query: query,
        );
      });
    }
  }

  void updateFilteredWards(String query) {
    selectedWard = null;
    if (selectedDistrict != null) {
      setState(() {
        filteredWards = VietnamProvinces.getWards(
          provinceCode: selectedProvince!.code,
          districtCode: selectedDistrict!.code,
          query: query,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vietnam Provinces Picker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDropdownSection(
              title: "Select Province",
              hintText: "Search for a province",
              items: filteredProvinces.map((p) => p.name).toList(),
              onSearchChanged: updateFilteredProvinces,
              currentValueSelected: selectedProvince?.name,
              onItemSelected: (value) {
                setState(() {
                  selectedProvince =
                      filteredProvinces.firstWhere((p) => p.name == value);
                  selectedDistrict = null;
                  selectedWard = null;
                  filteredDistricts = VietnamProvinces.getDistricts(
                    provinceCode: selectedProvince!.code,
                  );
                });
              },
            ),
            if (selectedProvince != null)
              buildDropdownSection(
                title: "Select District",
                hintText: "Search for a district",
                items: filteredDistricts.map((d) => d.name).toList(),
                onSearchChanged: updateFilteredDistricts,
                currentValueSelected: selectedDistrict?.name,
                onItemSelected: (value) {
                  setState(() {
                    selectedDistrict =
                        filteredDistricts.firstWhere((d) => d.name == value);
                    selectedWard = null;
                    filteredWards = VietnamProvinces.getWards(
                      provinceCode: selectedProvince!.code,
                      districtCode: selectedDistrict!.code,
                    );
                  });
                },
              ),
            if (selectedDistrict != null)
              buildDropdownSection(
                title: "Select Ward",
                hintText: "Search for a ward",
                items: filteredWards.map((w) => w.name).toList(),
                onSearchChanged: updateFilteredWards,
                currentValueSelected: selectedWard?.name,
                onItemSelected: (value) {
                  setState(() {
                    selectedWard =
                        filteredWards.firstWhere((w) => w.name == value);
                  });
                },
              ),
            if (selectedWard != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Selected: ${selectedProvince?.name} - ${selectedDistrict?.name} - ${selectedWard?.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownSection({
    required String title,
    required String hintText,
    required List<String> items,
    required void Function(String query) onSearchChanged,
    required void Function(String selectedItem) onItemSelected,
    required String? currentValueSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: currentValueSelected,
            isExpanded: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, overflow: TextOverflow.ellipsis),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) onItemSelected(value);
            },
          ),
        ],
      ),
    );
  }
}
