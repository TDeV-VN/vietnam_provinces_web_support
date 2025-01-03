/// Represents a ward within a district.
class Ward {
  /// The unique code of the ward.
  final int code;

  /// The name of the ward.
  final String name;

  /// Creates a new [Ward] instance.
  Ward({required this.code, required this.name});

  /// Creates a new [Ward] instance from a JSON object.
  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      code: json['code'],
      name: json['name'],
    );
  }
}
