import 'package:car_monitor/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../model/fuel_model.dart';

abstract class FuelRepo {
  Future<Either<Failure, FuelModel>> getFuelData();
}
