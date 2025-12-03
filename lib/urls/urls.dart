class URLS {
  String base_url = "http://192.168.0.190:8000/";
  String register_url = "api/register/";
  String area_url = "get_areas";
  String division_url = "get_division";
  String branch_url = "get_branches";
  String country_url = "get_country";
  String bar_association_url = "get_member_bar_association";
  String type_of_application_url = "get_type_of_application";
  String type_of_post_url = "get_type_of_post";
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

  String get barAssociationUrl => bar_association_url;
  set barAssociationUrl(String value) => bar_association_url = value;

  String get typeOfApplicationUrl => type_of_application_url;
  set typeOfApplicationUrl(String value) => type_of_application_url = value;

  String get typeOfPostUrl => type_of_post_url;
  set typeOfPostUrl(String value) => type_of_post_url = value;

  String get registerUrl => register_url;
  set registerUrl(String value) => register_url = value;
}
