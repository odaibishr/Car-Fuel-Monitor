import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/models/route_path.dart';
import 'package:location/location.dart';


import 'package:latlong2/latlong.dart';

abstract class MapRepository {
  Future<LocationData> getCurrentLocation();
  Stream<LocationData> listenToLocationChanges();
  Future<List<FuelStationModel>> fetchNearbyFuelStations(
      double lat, double lon, double radius);
  Future<RouteResponseModel> getRoute(LatLng start, LatLng destination);
}
