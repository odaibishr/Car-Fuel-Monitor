
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
}
