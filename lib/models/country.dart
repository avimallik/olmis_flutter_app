class Country {
  final int id;
  final String nameCountry;

  Country({required this.id, required this.nameCountry});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      nameCountry: json['name_country'],
    );
  }
}
