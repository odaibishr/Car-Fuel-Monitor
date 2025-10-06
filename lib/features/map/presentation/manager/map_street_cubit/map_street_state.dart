part of 'map_street_cubit.dart';

abstract class MapState {
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
  final double? nearestStationDistance;
  final FuelStationModel? nearestStation;

  const MapLocationLoaded({
    required this.location,
    this.fuelStations = const [],
    this.markers = const [],
    this.routePoints = const [],
    this.nearestStationDistance,
    this.nearestStation,
  });

  MapLocationLoaded copyWith({
    LocationData? location,
    List<FuelStationModel>? fuelStations,
    List<Marker>? markers,
    List<LatLng>? routePoints,
    double? nearestStationDistance,
    FuelStationModel? nearestStation,
  }) {
    return MapLocationLoaded(
      location: location ?? this.location,
      fuelStations: fuelStations ?? this.fuelStations,
      markers: markers ?? this.markers,
      routePoints: routePoints ?? this.routePoints,
      nearestStationDistance:
          nearestStationDistance ?? this.nearestStationDistance,
      nearestStation: nearestStation ?? this.nearestStation,
    );
  }

  @override
  List<Object?> get props => [
    location,
    fuelStations,
    markers,
    routePoints,
    nearestStationDistance,
    nearestStation,
  ];
}

class MapError extends MapState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object?> get props => [message];
}
