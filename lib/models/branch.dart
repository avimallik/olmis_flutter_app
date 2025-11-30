class Branch {
  final int branchId;
  final String branchName;
  final String branchCode;

  Branch({
    required this.branchId,
    required this.branchName,
    required this.branchCode,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      branchId: json['branch_id'],
      branchName: json['branch_name'],
      branchCode: json['branch_code'],
    );
  }
}
