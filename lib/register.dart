import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/division.dart';
import 'models/area.dart';
import 'models/branch.dart';
import 'models/country.dart';
import 'urls/urls.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();

  // urls
  URLS urls = URLS();

  // Dropdown variables
  List<Division> divisionList = [];
  Division? selectedDivision;

  // Area list
  List<Area> areaList = [];
  Area? selectedArea;

  //Country list
  List<Country> countryList = [];
  Country? selectedCountry;

  // ------ Branch ------
  List<Branch> branchList = [];
  Branch? selectedBranch;

  @override
  void initState() {
    super.initState();
    fetchDivisionData();
    fetchCountrynData();
  }

// Fetch API Data
  Future<void> fetchDivisionData() async {
    final url = Uri.parse(urls.baseUrl + urls.divisionUrl);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      List divisions = data["divisions"];

      setState(() {
        divisionList =
            divisions.map((item) => Division.fromJson(item)).toList();
      });
    } else {
      print("API Error");
    }
  }

  // ====== GET AREAS API (based on divisionID) ======
  Future<void> fetchAreaData(int divisionId) async {
    final url = Uri.parse(
        urls.baseUrl + urls.areaUrl + urls.slash + divisionId.toString());
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      setState(() {
        // FIXED → handles both array OR {"areas": [...]}
        final list = data is List ? data : data["areas"];
        areaList = list.map<Area>((item) => Area.fromJson(item)).toList();
      });
    }
  }

// ---------------- Fetch Branches ----------------
  Future<void> fetchBranches(int divisionId, int areaId) async {
    final url = Uri.parse(urls.baseUrl +
        urls.branchUrl +
        urls.slash +
        divisionId.toString() +
        urls.slash +
        areaId.toString());
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      setState(() {
        branchList = data.map<Branch>((item) => Branch.fromJson(item)).toList();
      });
    }
  }

// Fetch API Data
  Future<void> fetchCountrynData() async {
    final url = Uri.parse(urls.baseUrl + urls.countryUrl);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      List country = data["country"];

      setState(() {
        countryList = country.map((item) => Country.fromJson(item)).toList();
      });
    } else {
      print("API Error");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name',
              ),
            ),
            const SizedBox(height: 15),

            // ------------------ Division Dropdown -------------------
            const Text('Division',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            divisionList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<Division>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text("Select"),
                    value: selectedDivision,
                    items: divisionList.map((division) {
                      return DropdownMenuItem(
                        value: division,
                        child: Text(division.divisionName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDivision = value;

                        // Reset area & branch
                        selectedArea = null;
                        areaList.clear();

                        selectedBranch = null;
                        branchList.clear();
                      });

                      // Fetch Area Based On Division ID
                      fetchAreaData(value!.divisionId);

                      // Show Snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "ID: ${value!.divisionId} | "
                            "Name: ${value.divisionName} | "
                            "Code: ${value.divisionCode}",
                          ),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 15),
            // ------------------ Area Dropdown -------------------
            const Text('Area', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            DropdownButtonFormField<Area>(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text("Select Area"),
              value: selectedArea,
              items: areaList.map((area) {
                return DropdownMenuItem(
                  value: area,
                  child: Text(area.areaName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedArea = value;
                  // Reset branch
                  selectedBranch = null;
                  branchList.clear();
                });

                fetchBranches(selectedDivision!.divisionId, value!.areaId);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Area ID: ${value!.areaId} | "
                      "Name: ${value.areaName} | "
                      "Code: ${value.areaCode}",
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            // ---------- Branch Dropdown ----------
            const Text("Branch", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            DropdownButtonFormField<Branch>(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text("Select Branch"),
              value:
                  branchList.contains(selectedBranch) ? selectedBranch : null,
              items: branchList.map((branch) {
                return DropdownMenuItem(
                  value: branch,
                  child: Text(branch.branchName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBranch = value;
                });

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Branch ID: ${value!.branchId} | "
                    "Name: ${value.branchName} | "
                    "Code: ${value.branchCode}",
                  ),
                ));
              },
            ),
            const SizedBox(height: 15),
            //----------- Country Dropdown ---------
            const Text('Country',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            countryList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<Country>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text("Select"),
                    value: selectedCountry,
                    items: countryList.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Text(country.nameCountry),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;
                      });

                      // Fetch Area Based On Division ID
                      // fetchAreaData(value!.divisionId);

                      // Show Snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("ID: ${value!.id} | "
                              "Name: ${value.nameCountry} | "),
                        ),
                      );
                    },
                  ),

            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final roll = _rollController.text;
                // Simple action: show values in a SnackBar
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Name: $name, Roll: $roll'),
                ));
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
