class FuelModel {
  final int? id;
  final String? createdAt;
  final double? letters;
  final double? level;

  FuelModel({this.id, this.createdAt, this.letters, this.level});

  factory FuelModel.fromJson(Map<String, dynamic> json) {
    return FuelModel(
      id: json['id'],
      createdAt: json['created_at'],
      letters: json['leter'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'leter': letters,
      'level': level,
    };
  }
}
