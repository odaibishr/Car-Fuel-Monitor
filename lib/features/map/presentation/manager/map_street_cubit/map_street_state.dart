part of 'map_street_cubit.dart';

@immutable
sealed class MapStreetState {}

final class MapStreetInitial extends MapStreetState {}

final class MapStreetLoading extends MapStreetState {}

final class MapStreetSuccess extends MapStreetState {
  final List<FuelStation>? fuelStations;
  final LocationData? currentLocation;
  final List<LatLng>? routePoints;
  final List<Marker>? markers;
  final double? nearestDistance;


  MapStreetSuccess({
    this.routePoints,
    this.markers,
    this.nearestDistance,
    this.fuelStations,
    this.currentLocation,
  });
}

final class MapStreetError extends MapStreetState {
  final String errorMessage;
  MapStreetError(this.errorMessage);
}
