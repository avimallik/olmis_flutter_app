class TypeOfApplication {
  final int id;
  final String status;
  final String applicationType;

  TypeOfApplication({
    required this.id,
    required this.status,
    required this.applicationType,
  });

  factory TypeOfApplication.fromJson(Map<String, dynamic> json) {
    return TypeOfApplication(
      id: json['id'],
      status: json['status'],
      applicationType: json['application_type'],
    );
  }
}
