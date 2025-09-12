import 'package:car_monitor/core/api/dio_consumer.dart';
import 'package:car_monitor/core/errors/failure.dart';
import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/models/route_path.dart';
import 'package:car_monitor/features/map/data/repos/map_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapRepoImpl implements MapRepo {
  final Location _location = Location();
  final DioConsumer _dioConsumer;
  final String orsApiKey = dotenv.env['OPEN_STREET_MAP_API_KEY']!;

  MapRepoImpl(this._dioConsumer);
  @override
  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    try {
      final locationData = await _location.getLocation();
      return right(locationData);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FuelStation>>> getNearbyFuelStations(
      LatLng userLocation,
      {double radiusMeters = 5000}) async {
    try {
      final lat = userLocation.latitude;
      final lon = userLocation.longitude;
      final overpassUrl =
          "https://overpass-api.de/api/interpreter?data=[out:json];node[amenity=fuel](around:$radiusMeters,$lat,$lon);out;";
      final response = await _dioConsumer.get(overpassUrl);

      if (response.statusCode == 200) {
        final data = response.data;
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
      } else {
        return left(Failure('Failed to fetch fuel stations'));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RoutePath>> getRoute(
      {required LatLng start, required LatLng destination}) async {
    final url = Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}');
    final response = await _dioConsumer.get(url.toString());
    if (response.statusCode != 200) {
      return left(Failure('Failed to fetch route'));
    }
    final data = response.data;
    return right(RoutePath.fromJson(data));
  }

  @override
  Stream<Either<Failure, LocationData>> locationStream() {
    return _location.onLocationChanged.map((location) => right(location));
  }
}
