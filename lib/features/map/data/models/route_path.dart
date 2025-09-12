import 'package:latlong2/latlong.dart';

class RoutePath {
  final List<LatLng> points;

  const RoutePath({required this.points});

  factory RoutePath.fromJson(Map<String, dynamic> json) =>
      RoutePath(points: json['points']);
}
