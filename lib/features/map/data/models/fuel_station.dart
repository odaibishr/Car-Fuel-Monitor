class FuelStationModel {
  final String name;
  final double latitude;
  final double longitude;
  final String address;

  FuelStationModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory FuelStationModel.fromJson(Map<String, dynamic> json) {
    return FuelStationModel(
      name: json['tags']?['name'] ?? "محطة وقود غير معروفة",
      latitude: json['lat'],
      longitude: json['lon'],
      address: json['tags']?['addr:street'] ?? "غير متوفر",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}