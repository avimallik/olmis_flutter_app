class URLS {
  String base_url = "http://192.168.0.190:8000/";
  String area_url = "get_areas";
  String division_url = "get_division";
  String branch_url = "get_branches";
  String country_url = "get_country";
  String slash = "/";

  String get baseUrl => base_url;
  set baseUrl(String value) => base_url = value;

  String get areaUrl => area_url;
  set areaUrl(String value) => area_url = value;

  String get divisionUrl => division_url;
  set divisionUrl(String value) => division_url = value;

  String get branchUrl => branch_url;
  set branchUrl(String value) => branch_url = value;

  String get countryUrl => country_url;
  set countryUrl(String value) => country_url = value;

  String get slashUrl => slash;
  set slashUrl(String value) => slash = value;
}
