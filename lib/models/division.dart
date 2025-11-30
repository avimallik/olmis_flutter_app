class Division {
  final int divisionId;
  final String divisionName;
  final String divisionCode;

  Division({
    required this.divisionId,
    required this.divisionName,
    required this.divisionCode,
  });

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      divisionId: json['division_id'],
      divisionName: json['division_name'],
      divisionCode: json['division_code'],
    );
  }
}
