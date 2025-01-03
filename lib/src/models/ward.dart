class Ward {
  final int code;
  final String name;

  Ward({required this.code, required this.name});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      code: json['code'],
      name: json['name'],
    );
  }
}
