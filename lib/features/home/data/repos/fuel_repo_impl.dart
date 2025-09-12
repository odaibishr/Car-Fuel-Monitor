import 'dart:developer';

import 'package:car_monitor/core/api/dio_consumer.dart';
import 'package:car_monitor/core/api/end_points.dart';
import 'package:car_monitor/core/errors/failure.dart';
import 'package:car_monitor/features/home/data/model/fuel_model.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo.dart';
import 'package:dartz/dartz.dart';

class FuelRepoImpl implements FuelRepo {
  final DioConsumer dioConsumer;

  FuelRepoImpl(this.dioConsumer);

  @override
  Future<Either<Failure, FuelModel>> getFuelData() async {
    try {
      final response = await dioConsumer.get(
        "feeds.json?api_key=${EndPoints.apiKey}&results=2",
      );
      log(response.toString());
      if (response is Map<String, dynamic>) {
        return right(FuelModel.fromJson(response["feeds"][0]));
      } else {
        return left(
            Failure('Unexpected response type: "${response.runtimeType}"'));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
