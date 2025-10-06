class FuelModel {
  final int? id;
  final String? createdAt;
  final double? letters;
  final double? level;

  FuelModel({this.id, this.createdAt, this.letters, this.level});

  factory FuelModel.fromJson(Map<String, dynamic> json) {
    return FuelModel(
      id: json['id'] as int?,
      createdAt: json['created_at'] as String?,
      letters: (json['leter'] as num?)?.toDouble(),
      level: (json['level'] as num?)?.toDouble(),
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
