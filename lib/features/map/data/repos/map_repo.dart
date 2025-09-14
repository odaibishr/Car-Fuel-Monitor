import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/models/route_path.dart';
import 'package:location/location.dart';


<<<<<<< HEAD
import 'package:latlong2/latlong.dart';
=======
  Future<Either<Failure, List<FuelStation>>> getNearbyFuelStations(
    LocationData userLocation, {
    double radiusMeters = 5000,
  });
>>>>>>> f6b0278cc2da0d80fd33ddb76eae8343a9fdd8a4

abstract class MapRepository {
  Future<LocationData> getCurrentLocation();
  Stream<LocationData> listenToLocationChanges();
  Future<List<FuelStationModel>> fetchNearbyFuelStations(
      double lat, double lon, double radius);
  Future<RouteResponseModel> getRoute(LatLng start, LatLng destination);
}
