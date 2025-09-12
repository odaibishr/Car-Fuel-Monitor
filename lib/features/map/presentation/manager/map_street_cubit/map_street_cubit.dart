import 'package:bloc/bloc.dart';
import 'package:car_monitor/features/map/data/models/fuel_station.dart';
import 'package:car_monitor/features/map/data/repos/map_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:car_monitor/core/errors/failure.dart';

part 'map_street_state.dart';

class MapStreetCubit extends Cubit<MapStreetState> {
  MapStreetCubit(this.mapRepo) : super(MapStreetInitial());

  final MapRepo mapRepo;

  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    emit(MapStreetLoading());
    try {
      var locations = LocationData.fromMap({});
      var locationData = await mapRepo.getCurrentLocation();
      locationData.fold((failure) => emit(MapStreetError(failure.errorMessage)),
          (location) {
        emit(MapStreetSuccess(currentLocation: location));
        locations = location;
      });
      return Right(locations);
    } catch (e) {
      emit(MapStreetError(e.toString()));
      return Left(Failure(e.toString()));
    }
  }

  Future<void> getNearbyFuelStations() async {
    emit(MapStreetLoading());
    try {
      final locationResult = await getCurrentLocation();

      return locationResult.fold(
        (failure) {
          emit(MapStreetError('Location error: ${failure.errorMessage}'));
        },
        (location) async {
          if (location.latitude == null || location.longitude == null) {
            emit(MapStreetError('Location data is not available'));
            return;
          }
          try {
            final result = await mapRepo.getNearbyFuelStations(location);

            result.fold(
              (failure) {
                emit(MapStreetError(
                    'Failed to fetch stations: ${failure.errorMessage}'));
              },
              (stations) {
                emit(MapStreetSuccess(
                  fuelStations: stations,
                  currentLocation: location,
                ));
              },
            );
          } catch (e) {
            emit(MapStreetError('Error fetching stations: $e'));
          }
        },
      );
    } catch (e) {
      emit(MapStreetError('An unexpected error occurred'));
    }
  }
}
