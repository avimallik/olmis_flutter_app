class BarAssociation {
  final int id;
  final String name_member_of_bar_association;

  BarAssociation({
    required this.id,
    required this.name_member_of_bar_association,
  });

  factory BarAssociation.fromJson(Map<String, dynamic> json) {
    return BarAssociation(
      id: json['id'],
      name_member_of_bar_association: json['name_member_of_bar_association'],
    );
  }
}
