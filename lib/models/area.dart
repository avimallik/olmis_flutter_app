class Area {
  final int areaId;
  final String areaName;
  final String areaCode;

  Area({
    required this.areaId,
    required this.areaName,
    required this.areaCode,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      areaId: json['area_id'],
      areaName: json['area_name'],
      areaCode: json['area_code'],
    );
  }
}
