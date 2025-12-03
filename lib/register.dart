import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'models/division.dart';
import 'models/area.dart';
import 'models/branch.dart';
import 'models/country.dart';
import 'models/bar_association.dart';
import 'models/type_of_application.dart';
import 'models/type_of_post.dart';

import 'urls/urls.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _applicationSessionController =
      TextEditingController();

  final TextEditingController nameEng = TextEditingController();
  final TextEditingController nameBan = TextEditingController();

  final TextEditingController barCouncilPassingYear = TextEditingController();
  final TextEditingController barCouncilCertNo = TextEditingController();

  final TextEditingController permissionHighCourtYear = TextEditingController();
  final TextEditingController barMembershipNo = TextEditingController();

  final TextEditingController addrPresentEng = TextEditingController();
  final TextEditingController addrPresentBan = TextEditingController();

  final TextEditingController addrPermanentEng = TextEditingController();
  final TextEditingController addrPermanentBan = TextEditingController();

  final TextEditingController barAtLaw = TextEditingController();

  final TextEditingController chamberCourtEng = TextEditingController();
  final TextEditingController chamberCourtBan = TextEditingController();

  final TextEditingController chamberPersonalEng = TextEditingController();
  final TextEditingController chamberPersonalBan = TextEditingController();

  final TextEditingController emailField = TextEditingController();

  final TextEditingController mobileField = TextEditingController();
  final TextEditingController nidField = TextEditingController();

  final TextEditingController experiences = TextEditingController();
  final TextEditingController otherAcademic = TextEditingController();

  final TextEditingController passportField = TextEditingController();
  final TextEditingController overseasId = TextEditingController();

  final TextEditingController diploma = TextEditingController();
  final TextEditingController training = TextEditingController();

  final TextEditingController highestEducation = TextEditingController();
  final TextEditingController codiceFiscale = TextEditingController();
  final TextEditingController hoInwardNo = TextEditingController();

  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  URLS urls = URLS();

  // Division
  List<Division> divisionList = [];
  Division? selectedDivision;

  // Area
  List<Area> areaList = [];
  Area? selectedArea;

  // Branch
  List<Branch> branchList = [];
  Branch? selectedBranch;

  // Country
  List<Country> countryList = [];
  Country? selectedCountry;

  // Bar Association
  List<BarAssociation> barAssociationList = [];
  BarAssociation? selectedBarAssociation;

  // Type of Application
  List<TypeOfApplication> typeOfApplicationList = [];
  TypeOfApplication? selectedTypeOfApplication;

  //Type of Post
  List<TypeOfPost> typeOfPostList = [];
  TypeOfPost? selectedTypeOfPost;

  @override
  void initState() {
    super.initState();
    fetchDivisionData();
    fetchCountrynData();
    fetchBarAssociation();
    fetchTypeOfApplication();
    fetchTypeOfPost();
  }

  // ---------------- Division API ----------------
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
    }
  }

  // ---------------- Area API ----------------
  Future<void> fetchAreaData(int divisionId) async {
    final url = Uri.parse(
        urls.baseUrl + urls.areaUrl + urls.slash + divisionId.toString());
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      setState(() {
        final list = data is List ? data : data["areas"];
        areaList = list.map<Area>((item) => Area.fromJson(item)).toList();
      });
    }
  }

  // ---------------- Branch API ----------------
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

  // ---------------- Country API ----------------
  Future<void> fetchCountrynData() async {
    final url = Uri.parse(urls.baseUrl + urls.countryUrl);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      List country = data["country"];

      setState(() {
        countryList = country.map((item) => Country.fromJson(item)).toList();
      });
    }
  }

  // ---------------- Bar Association API ----------------
  Future<void> fetchBarAssociation() async {
    final url = Uri.parse(urls.baseUrl + urls.barAssociationUrl);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      List barAssociation = data["member_of_bar_association"];

      setState(() {
        barAssociationList = barAssociation
            .map((item) => BarAssociation.fromJson(item))
            .toList();
      });
    }
  }

  // ---------------- Type of Application API ----------------
  Future<void> fetchTypeOfApplication() async {
    final url = Uri.parse(urls.baseUrl + urls.typeOfApplicationUrl);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      List appList = data["type_of_application"];

      setState(() {
        typeOfApplicationList =
            appList.map((item) => TypeOfApplication.fromJson(item)).toList();
      });
    }
  }

  // ---------------- Type of Application API ----------------
  Future<void> fetchTypeOfPost() async {
    final url = Uri.parse(urls.baseUrl + urls.typeOfPostUrl);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      List appList = data["type_of_post"];

      setState(() {
        typeOfPostList =
            appList.map((item) => TypeOfPost.fromJson(item)).toList();
      });
    }
  }

  //--------ORA Date Format------------
  String convertToYMD(String ddmmyyyy) {
    try {
      final parts = ddmmyyyy.split('-');
      if (parts.length != 3) return ddmmyyyy;

      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];

      return "$year-$month-$day"; // YYYY-MM-DD
    } catch (e) {
      return ddmmyyyy;
    }
  }

//----------Registration post-----------
  // Future<void> submitForm() async {
  //   final url = Uri.parse("http://192.168.0.190:8000/api/register/");

  //   // Flutter → JSON Body
  //   final body = {
  //     "division_id": selectedDivision?.divisionId,
  //     "area_id": selectedArea?.areaId,
  //     "branch_id": selectedBranch?.branchId,

  //     "country": selectedCountry?.nameCountry,
  //     "type_of_application": selectedTypeOfApplication?.applicationType,
  //     "type_of_post": selectedTypeOfPost?.postType,
  //     "member_of_bar_association":
  //         selectedBarAssociation?.name_member_of_bar_association,

  //     "name_english": nameEng.text,
  //     "name_bangla": nameBan.text,

  //     "bar_council_passing_year": barCouncilPassingYear.text,
  //     "bar_council_certificate_no": barCouncilCertNo.text,

  //     "year_permission_practice_high_court": permissionHighCourtYear.text,
  //     "bar_association_membership_no": barMembershipNo.text,

  //     "bar_at_law": barAtLaw.text,

  //     "address_present_english": addrPresentEng.text,
  //     "address_present_bangla": addrPresentBan.text,

  //     "address_permanent_english": addrPermanentEng.text,
  //     "address_permanent_bangla": addrPermanentBan.text,

  //     "address_court_chamber_english": chamberCourtEng.text,
  //     "address_court_chamber_bangla": chamberCourtBan.text,

  //     "address_personal_chamber_english": chamberPersonalEng.text,
  //     "address_personal_chamber_bangla": chamberPersonalBan.text,

  //     "email": emailField.text,
  //     "mobile": mobileField.text,
  //     "nid": nidField.text,

  //     "experiences": experiences.text,
  //     "other_academic_qualifications": otherAcademic.text,

  //     "passport_no": passportField.text,
  //     "passport_expiry_date":
  //         convertToYMD(_expiryDateController.text), // DD-MM-YYYY

  //     "overseas_national_id": overseasId.text,
  //     "diploma_or_professional_degree": diploma.text,

  //     "other_training": training.text,

  //     "date_of_birth": convertToYMD(_dateOfBirthController.text), // DD-MM-YYYY
  //     "application_session": convertToYMD(_applicationSessionController.text),

  //     "highest_education": highestEducation.text,
  //     "codice_fiscale": codiceFiscale.text,
  //     "document_ho_inward_no": hoInwardNo.text,
  //   };

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(body),
  //     );

  //     final resData = jsonDecode(response.body);

  //     if (response.statusCode == 200 && resData["success"] == true) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Registration Successful!")),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Error: ${resData["error"]}")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Exception: $e")),
  //     );
  //   }
  // }

  Future<void> submitForm() async {
    final url = Uri.parse(urls.baseUrl + urls.registerUrl);

    try {
      var request = http.MultipartRequest("POST", url);

      // ----------- IMAGE FILE -------------
      if (selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "photo_filename",
            selectedImage!.path,
          ),
        );
      }

      // ----------- NORMAL TEXT FIELDS -------------
      request.fields["division_id"] =
          selectedDivision?.divisionId.toString() ?? "";
      request.fields["area_id"] = selectedArea?.areaId.toString() ?? "";
      request.fields["branch_id"] = selectedBranch?.branchId.toString() ?? "";

      request.fields["country"] = selectedCountry?.nameCountry ?? "";
      request.fields["type_of_application"] =
          selectedTypeOfApplication?.applicationType ?? "";
      request.fields["type_of_post"] = selectedTypeOfPost?.postType ?? "";
      request.fields["member_of_bar_association"] =
          selectedBarAssociation?.name_member_of_bar_association ?? "";

      request.fields["name_english"] = nameEng.text;
      request.fields["name_bangla"] = nameBan.text;

      request.fields["bar_council_passing_year"] = barCouncilPassingYear.text;
      request.fields["bar_council_certificate_no"] = barCouncilCertNo.text;

      request.fields["year_permission_practice_high_court"] =
          permissionHighCourtYear.text;
      request.fields["bar_association_membership_no"] = barMembershipNo.text;

      request.fields["bar_at_law"] = barAtLaw.text;

      request.fields["address_present_english"] = addrPresentEng.text;
      request.fields["address_present_bangla"] = addrPresentBan.text;

      request.fields["address_permanent_english"] = addrPermanentEng.text;
      request.fields["address_permanent_bangla"] = addrPermanentBan.text;

      request.fields["address_court_chamber_english"] = chamberCourtEng.text;
      request.fields["address_court_chamber_bangla"] = chamberCourtBan.text;

      request.fields["address_personal_chamber_english"] =
          chamberPersonalEng.text;
      request.fields["address_personal_chamber_bangla"] =
          chamberPersonalBan.text;

      request.fields["email"] = emailField.text;
      request.fields["mobile"] = mobileField.text;
      request.fields["nid"] = nidField.text;

      request.fields["experiences"] = experiences.text;
      request.fields["other_academic_qualifications"] = otherAcademic.text;

      request.fields["passport_no"] = passportField.text;
      request.fields["passport_expiry_date"] =
          convertToYMD(_expiryDateController.text);

      request.fields["overseas_national_id"] = overseasId.text;
      request.fields["diploma_or_professional_degree"] = diploma.text;

      request.fields["other_training"] = training.text;

      request.fields["date_of_birth"] =
          convertToYMD(_dateOfBirthController.text);
      request.fields["application_session"] =
          convertToYMD(_applicationSessionController.text);

      request.fields["highest_education"] = highestEducation.text;
      request.fields["codice_fiscale"] = codiceFiscale.text;
      request.fields["document_ho_inward_no"] = hoInwardNo.text;

      // ----------- SEND REQUEST -------------
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var resData = jsonDecode(responseBody);

      if (response.statusCode == 200 && resData["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful!")),
        );
        // clearAllFields();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${resData["error"]}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e")),
      );
    }
  }

  //--------Image Selection----------
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void clearAllFields() {
    nameEng.clear();
    nameBan.clear();
    barCouncilPassingYear.clear();
    barCouncilCertNo.clear();
    permissionHighCourtYear.clear();
    barMembershipNo.clear();
    addrPresentEng.clear();
    addrPresentBan.clear();
    addrPermanentEng.clear();
    addrPermanentBan.clear();
    barAtLaw.clear();
    chamberCourtEng.clear();
    chamberCourtBan.clear();
    chamberPersonalEng.clear();
    chamberPersonalBan.clear();
    emailField.clear();
    mobileField.clear();
    nidField.clear();
    experiences.clear();
    otherAcademic.clear();
    passportField.clear();
    overseasId.clear();
    diploma.clear();
    training.clear();
    highestEducation.clear();
    codiceFiscale.clear();
    hoInwardNo.clear();

    _expiryDateController.clear();
    _dateOfBirthController.clear();
    _applicationSessionController.clear();

    // Dropdown reset
    selectedDivision = null;
    selectedArea = null;
    selectedBranch = null;
    selectedCountry = null;
    selectedBarAssociation = null;
    selectedTypeOfApplication = null;

    areaList.clear();
    branchList.clear();

    setState(() {});
  }

  @override
  void dispose() {
    _dateOfBirthController.dispose();
    _applicationSessionController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  Widget buildField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- Division ----------------
              const Text("Division",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),

              DropdownButtonFormField<Division>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text("Select Division"),
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

                    selectedArea = null;
                    areaList.clear();

                    selectedBranch = null;
                    branchList.clear();
                  });

                  fetchAreaData(value!.divisionId);
                },
              ),

              const SizedBox(height: 20),

              // ---------------- Area ----------------
              const Text("Area", style: TextStyle(fontWeight: FontWeight.bold)),
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

                    selectedBranch = null;
                    branchList.clear();
                  });

                  fetchBranches(selectedDivision!.divisionId, value!.areaId);
                },
              ),

              const SizedBox(height: 20),

              // ---------------- Branch ----------------
              const Text("Branch",
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
                },
              ),

              const SizedBox(height: 20),

              // ---------------- Country ----------------
              const Text("Country",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),

              DropdownButtonFormField<Country>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text("Select Country"),
                value: selectedCountry,
                items: countryList.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country.nameCountry),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedCountry = value);
                },
              ),

              const SizedBox(height: 20),

              // ---------------- Bar Association ----------------
              const Text("Member of Bar Association",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),

              DropdownButtonFormField<BarAssociation>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text("Select"),
                value: selectedBarAssociation,
                items: barAssociationList.map((bar) {
                  return DropdownMenuItem(
                    value: bar,
                    child: Text(bar.name_member_of_bar_association),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedBarAssociation = value);
                },
              ),

              const SizedBox(height: 20),

              // ---------------- Type of Application ----------------
              const Text("Type of Application",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),

              DropdownButtonFormField<TypeOfApplication>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text("Select Type"),
                value: selectedTypeOfApplication,
                items: typeOfApplicationList.map((app) {
                  return DropdownMenuItem(
                    value: app,
                    child: Text(app.applicationType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedTypeOfApplication = value);
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // ----- Date of Birth Date -----
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Date of Birth",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _dateOfBirthController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Select",
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                _dateOfBirthController.text =
                                    "${picked.day}-${picked.month}-${picked.year}";
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ----- Application Session Date -----
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Application Session",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _applicationSessionController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Select",
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                _applicationSessionController.text =
                                    "${picked.day}-${picked.month}-${picked.year}";
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              //-------name------------
              Row(
                children: [
                  Expanded(child: buildField("Name (English)", nameEng)),
                  const SizedBox(width: 12),
                  Expanded(child: buildField("Name (Bangla)", nameBan)),
                ],
              ),
              const SizedBox(height: 12),
              //-------year permission practice & bar Association membership no------------
              Row(
                children: [
                  Expanded(
                      child: buildField("Year Permission Practice High Court",
                          permissionHighCourtYear)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: buildField(
                          "Bar Association Membership No", barMembershipNo)),
                ],
              ),
              const SizedBox(height: 12),
              //-------bar council passing year and certificate no------------
              Row(
                children: [
                  Expanded(
                      child: buildField(
                          "Bar Council Passing Year", barCouncilPassingYear)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: buildField(
                          "Bar Council Certificate No", barCouncilCertNo)),
                ],
              ),
              const SizedBox(height: 16),
              //-------adrees present bangla and english------------
              Row(
                children: [
                  Expanded(
                      child: buildField(
                          "Address Present (English)", addrPresentEng)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: buildField(
                          "Address Present (Bangla)", addrPresentBan)),
                ],
              ),
              const SizedBox(height: 16),
              //----------- Address permanent english and bangla--------
              Row(
                children: [
                  Expanded(
                      child: buildField(
                          "Address Permanent (English)", addrPermanentEng)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: buildField(
                          "Address Permanent (Bangla)", addrPermanentBan)),
                ],
              ),
              //--Bar at law
              const SizedBox(height: 16),
              buildField("Bar-at-Law", barAtLaw),
              const SizedBox(height: 16),
              //------Adress court chamber bangla and english----------
              Row(
                children: [
                  Expanded(
                      child: buildField(
                          "Address Court Chamber (English)", chamberCourtEng)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: buildField(
                          "Address Court Chamber (Bangla)", chamberCourtBan)),
                ],
              ),
              const SizedBox(height: 16),
              //---------Personal chamber address bangla and english
              Row(
                children: [
                  Expanded(
                      child: buildField("Address Personal Chamber (English)",
                          chamberPersonalEng)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: buildField("Address Personal Chamber (Bangla)",
                          chamberPersonalBan)),
                ],
              ),
              const SizedBox(height: 16),
              //-------Email--------
              buildField("Email", emailField),

              //----------Mobile and NID-----
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: buildField("Mobile", mobileField)),
                  const SizedBox(width: 12),
                  Expanded(child: buildField("NID", nidField)),
                ],
              ),
              const SizedBox(height: 16),
              //------Experiences--------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Experiences",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: experiences,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //-------other academic qualification--------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Other Academic Qualifications",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: otherAcademic,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //------Passport and overseas id--------
              Row(
                children: [
                  Expanded(child: buildField("Passport No.", passportField)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: buildField("Overseas National ID", overseasId)),
                ],
              ),
              const SizedBox(height: 16),
              //-----------Professinal degree---------------
              Row(
                children: [
                  Expanded(
                      child:
                          buildField("Diploma/Professional Degree", diploma)),
                  const SizedBox(width: 12),
                  Expanded(child: buildField("Other Training", training)),
                ],
              ),
              const SizedBox(height: 16),
              //---Highest Education-----------
              buildField("Highest Education", highestEducation),
              const SizedBox(height: 16),
              //-----------Codice fiscale----------
              Row(
                children: [
                  Expanded(child: buildField("Codice Fiscale", codiceFiscale)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: buildField("Document HO Inward No", hoInwardNo)),
                ],
              ),
              const SizedBox(height: 12),

              //----------- Passport Expiry Date Picker--------

              const Text("Passport Expiry Date",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),

              TextField(
                controller: _expiryDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Select Date",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    String formatted =
                        "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                    setState(() {
                      _expiryDateController.text = formatted;
                    });
                  }
                },
              ),

              const SizedBox(height: 20),
              // ---------------- Type of Post ----------------
              const Text("Type of Post",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),

              DropdownButtonFormField<TypeOfPost>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text("Select Type"),
                value: selectedTypeOfPost,
                items: typeOfPostList.map((app) {
                  return DropdownMenuItem(
                    value: app,
                    child: Text(app.postType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedTypeOfPost = value);
                },
              ),
              const SizedBox(height: 20),
              const Text("Select Image"),
              //----Photo Upload UI--------
              Row(
                children: [
                  // ------- Browse Button -------
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text("Browse"),
                  ),

                  SizedBox(width: 16),

                  // ------- Image Preview -------
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: selectedImage == null
                        ? Center(child: Text("No Image"))
                        : Image.file(selectedImage!, fit: BoxFit.cover),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: () async {
                  await submitForm();
                  // clearAllFields();
                },
                child: const Text("Submit"),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
