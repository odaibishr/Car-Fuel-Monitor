import 'package:car_monitor/core/errors/failure.dart';
import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/models/route_path.dart';
import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

abstract class MapRepo {
  Future<Either<Failure, LocationData>> getCurrentLocation();
  Future<Either<Failure, LocationData>> locationStream();

  Future<Either<Failure, List<FuelStation>>> getNearbyFuelStations(
    LatLng userLocation, {
    double radiusMeters = 5000,
  });

  Future<Either<Failure, RoutePath>> getRoute({
    required LatLng start,
    required LatLng destination,
  });
}
