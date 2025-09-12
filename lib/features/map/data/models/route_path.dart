import 'package:latlong2/latlong.dart';

class RouteResponseModel {
  final List<LatLng> points;

  RouteResponseModel({required this.points});

  factory RouteResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> coords = json['features'][0]['geometry']['coordinates'];
    return RouteResponseModel(
      points: coords.map((coord) => LatLng(coord[1], coord[0])).toList(),
    );
  }
}
