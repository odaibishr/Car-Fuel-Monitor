class FuelModel {
  final double? letters;
  final double? level;

  FuelModel({this.letters, this.level});

  factory FuelModel.fromJson(Map<String, dynamic> json) {
    double? _toDouble(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }

    return FuelModel(
      letters: _toDouble(json['field4']),
      level: _toDouble(json['field3']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field4': letters,
      'field3': level,
    };
  }
}
