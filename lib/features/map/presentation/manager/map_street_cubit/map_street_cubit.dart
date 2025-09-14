import 'dart:async';

import 'package:car_monitor/core/theme/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/repos/map_repo.dart';

part 'map_street_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapRepository mapRepository;
  StreamSubscription<LocationData>? _locationSubscription;
  final Function(double) updateDistance;

  MapCubit({required this.mapRepository, required this.updateDistance})
      : super(MapInitial());

  Future<void> getCurrentLocation() async {
    emit(MapLoading());
    try {
      final location = await mapRepository.getCurrentLocation();
      location.fold((failure) => emit(MapError(message: failure.errorMessage)),
          (location) {
        emit(MapLocationLoaded(location: location));

        addMarker(
          LatLng(location.latitude!, location.longitude!),
          isCurrentLocation: true,
        );
      });
      await fetchNearbyFuelStations();
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> fetchNearbyFuelStations() async {
    final currentState = state;
    if (currentState is! MapLocationLoaded) return;

    try {
      final stations = await mapRepository.fetchNearbyFuelStations(
        currentState.location.latitude!,
        currentState.location.longitude!,
        5000, // 5km radius
      );

      emit(MapLocationLoaded(
        location: currentState.location,
        fuelStations: stations.fold((failure) => [], (stations) => stations),
        markers: currentState.markers,
        routePoints: currentState.routePoints,
      ));

      _navigateToNearestFuelStation();
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  void _navigateToNearestFuelStation() {
    final currentState = state;
    if (currentState is! MapLocationLoaded ||
        currentState.fuelStations.isEmpty) {
      return;
    }

    final nearestStation = _getNearestFuelStation(
      LatLng(currentState.location.latitude!, currentState.location.longitude!),
      currentState.fuelStations,
    );

    if (nearestStation != null) {
      getRoute(LatLng(nearestStation.latitude, nearestStation.longitude));
    }
  }

  FuelStationModel? _getNearestFuelStation(
      LatLng userLocation, List<FuelStationModel> stations) {
    FuelStationModel? nearestStation;
    double minDistance = double.infinity;

    for (var station in stations) {
      double distance = const Distance().as(
        LengthUnit.Kilometer,
        userLocation,
        LatLng(station.latitude, station.longitude),
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestStation = station;
      }
    }

    if (nearestStation != null) {
      updateDistance(minDistance);
    } else {
      updateDistance(0.0);
    }

    return nearestStation;
  }

  Future<void> getRoute(LatLng destination) async {
    final currentState = state;
    if (currentState is! MapLocationLoaded) return;

    try {
      final start = LatLng(
          currentState.location.latitude!, currentState.location.longitude!);
      final route = await mapRepository.getRoute(start, destination);

      addMarker(destination, isCurrentLocation: false);

      emit(MapLocationLoaded(
        location: currentState.location,
        fuelStations: currentState.fuelStations,
        markers: currentState.markers,
        routePoints: route.fold((failure) => [], (route) => route.points),
      ));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  void addMarker(LatLng point, {required bool isCurrentLocation}) {
    final currentState = state;
    if (currentState is! MapLocationLoaded) return;

    final newMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: point,
      child: Icon(
        isCurrentLocation ? Icons.my_location : Icons.location_on,
        color: ColorStyles.primaryColor,
        size: 40.0,
      ),
    );

    emit(MapLocationLoaded(
      location: currentState.location,
      fuelStations: currentState.fuelStations,
      markers: [...currentState.markers, newMarker],
      routePoints: currentState.routePoints,
    ));
  }

  void startListeningToLocation() {
    _locationSubscription =
        mapRepository.listenToLocationChanges().listen((newLocation) {
      final currentState = state;
      if (currentState is MapLocationLoaded) {
        emit(MapLocationLoaded(
          location: newLocation,
          fuelStations: currentState.fuelStations,
          markers: currentState.markers,
          routePoints: currentState.routePoints,
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
