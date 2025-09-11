part of 'fuel_cubit.dart';

sealed class FuelState {}

final class FuelInitial extends FuelState {}

final class FuelLoading extends FuelState {}

final class FuelSuccess extends FuelState {
  final FuelModel fuelModel;

  FuelSuccess({required this.fuelModel});
}

final class FuelError extends FuelState {
  final String message;

  FuelError({required this.message});
}

