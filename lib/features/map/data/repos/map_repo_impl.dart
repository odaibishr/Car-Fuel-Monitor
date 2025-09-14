import 'dart:developer';

import 'package:car_monitor/core/api/dio_consumer.dart';
import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/models/route_path.dart';
import 'package:car_monitor/features/map/data/repos/map_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:latlong2/latlong.dart';

class MapRepositoryImpl implements MapRepository {
  final Location _location = Location();
  final DioConsumer dioConsumer;
  final String orsApiKey = dotenv.env["OPEN_STREET_MAP_API_KEY"]!;

  MapRepositoryImpl(this.dioConsumer);

  @override
  Future<LocationData> getCurrentLocation() async {
    return await _location.getLocation();
  }

  @override
<<<<<<< HEAD
  Stream<LocationData> listenToLocationChanges() {
    return _location.onLocationChanged;
  }

  @override
  Future<List<FuelStationModel>> fetchNearbyFuelStations(
      double lat, double lon, double radius) async {
    final overpassUrl =
        "https://overpass-api.de/api/interpreter?data=[out:json];node[amenity=fuel](around:$radius,$lat,$lon);out;";

    try {
      final response = await dioConsumer.get(overpassUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['elements'] as List)
            .where((element) =>
                element.containsKey('lat') && element.containsKey('lon'))
            .map((element) => FuelStationModel.fromJson(element))
            .map((model) => FuelStationModel(
                  name: model.name,
                  latitude: model.latitude,
                  longitude: model.longitude,
                  address: model.address,
                ))
            .toList();
      } else {
        throw Exception(
            "Failed to fetch fuel stations: ${response.statusCode}");
      }
=======
  Future<Either<Failure, List<FuelStation>>> getNearbyFuelStations(
      LocationData userLocation,
      {double radiusMeters = 5000}) async {
    try {
      final lat = userLocation.latitude;
      final lon = userLocation.longitude;
      log("lat: $lat, lon: $lon");
      final overpassUrl =
          "https://overpass-api.de/api/interpreter?data=[out:json];node[amenity=fuel](around:$radiusMeters,$lat,$lon);out;";

      // DioConsumer.get returns the response body (decoded data), not a Response
      final data = await _dioConsumer.get(overpassUrl) as Map<String, dynamic>;
      final fuelStations = data['elements'] as List;
      return right(fuelStations
          .where((e) => e.containsKey('lat') && e.containsKey('lon'))
          .map<FuelStation>((e) => FuelStation(
                name: e['tags']?['name'] ?? 'محطة وقود غير معروفة',
                latitude: (e['lat'] as num).toDouble(),
                longitude: (e['lon'] as num).toDouble(),
                address: e['tags']?['addr:street'] ?? 'غير متوفر',
              ))
          .toList());
>>>>>>> f6b0278cc2da0d80fd33ddb76eae8343a9fdd8a4
    } catch (e) {
      throw Exception("Error fetching fuel stations: $e");
    }
  }

  @override
<<<<<<< HEAD
  Future<RouteResponseModel> getRoute(LatLng start, LatLng destination) async {
    final response = await dioConsumer.get(
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}',
    );
=======
  Future<Either<Failure, RoutePath>> getRoute(
      {required LatLng start, required LatLng destination}) async {
    try {
      final url = Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}');
      // DioConsumer.get returns the response body (decoded data)
      final data =
          await _dioConsumer.get(url.toString()) as Map<String, dynamic>;
      return right(RoutePath.fromJson(data));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
>>>>>>> f6b0278cc2da0d80fd33ddb76eae8343a9fdd8a4

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routeModel = RouteResponseModel.fromJson(data);
      return RouteResponseModel(points: routeModel.points);
    } else {
      throw Exception('Failed to fetch route: ${response.statusCode}');
    }
  }
}
