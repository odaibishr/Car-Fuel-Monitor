import 'package:car_monitor/core/errors/failure.dart';
import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/models/route_path.dart';
import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

abstract class MapRepository {
  Future<Either<Failure, LocationData>> getCurrentLocation();
  Stream<LocationData> listenToLocationChanges();
  Future<Either<Failure, List<FuelStationModel>>> fetchNearbyFuelStations(
      double lat, double lon, double radius);
  Future<Either<Failure, RouteResponseModel>> getRoute(
      LatLng start, LatLng destination);
}
