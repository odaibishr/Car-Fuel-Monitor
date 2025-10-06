import 'package:car_monitor/core/api/dio_consumer.dart';
import 'package:car_monitor/core/errors/failure.dart';
import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/models/route_path.dart';
import 'package:car_monitor/features/map/data/repos/map_repo.dart';
import 'package:dartz/dartz.dart';
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
  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    try {
      final location = await _location.getLocation();
      return Right(location);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<LocationData> listenToLocationChanges() {
    return _location.onLocationChanged.map((location) => location);
  }

  @override
  Future<Either<Failure, List<FuelStationModel>>> fetchNearbyFuelStations(
    double lat,
    double lon,
    double radius,
  ) async {
    final overpassUrl =
        "https://overpass-api.de/api/interpreter?data=[out:json];node[amenity=fuel](around:$radius,$lat,$lon);out;";

    try {
      final response = await dioConsumer.get(overpassUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(
          (data['elements'] as List)
              .where(
                (element) =>
                    element.containsKey('lat') && element.containsKey('lon'),
              )
              .map((element) => FuelStationModel.fromJson(element))
              .map(
                (model) => FuelStationModel(
                  name: model.name,
                  latitude: model.latitude,
                  longitude: model.longitude,
                  address: model.address,
                ),
              )
              .toList(),
        );
      } else {
        return Left(
          Failure("Failed to fetch fuel stations: ${response.statusCode}"),
        );
      }
    } catch (e) {
      return Left(Failure("Error fetching fuel stations: $e"));
    }
  }

  @override
  Future<Either<Failure, RouteResponseModel>> getRoute(
    LatLng start,
    LatLng destination,
  ) async {
    final response = await dioConsumer.get(
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routeModel = RouteResponseModel.fromJson(data);
      return Right(RouteResponseModel(points: routeModel.points));
    } else {
      return Left(Failure('Failed to fetch route: ${response.statusCode}'));
    }
  }
}
