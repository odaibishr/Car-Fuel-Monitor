<<<<<<< HEAD

part of 'map_street_cubit.dart';

abstract class MapState  {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLocationLoaded extends MapState {
  final LocationData location;
  final List<FuelStationModel> fuelStations;
  final List<Marker> markers;
  final List<LatLng> routePoints;

  const MapLocationLoaded({
    required this.location,
    this.fuelStations = const [],
    this.markers = const [],
    this.routePoints = const [],
  });

  @override
  List<Object?> get props => [location, fuelStations, markers, routePoints];
}

class MapError extends MapState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object?> get props => [message];
=======
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
>>>>>>> f6b0278cc2da0d80fd33ddb76eae8343a9fdd8a4
}
