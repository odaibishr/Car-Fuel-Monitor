class FuelModel {
  final double? letters;
  final double? level;

  FuelModel({this.letters, this.level});

  factory FuelModel.fromJson(Map<String, dynamic> json) {
    return FuelModel(
      letters: json['letters']?.toDouble(),
      level: json['level']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'letters': letters,
      'level': level,
    };
  }
}
