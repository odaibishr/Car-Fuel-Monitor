import 'dart:developer';

import 'package:car_monitor/core/errors/failure.dart';
import 'package:car_monitor/features/home/data/model/fuel_model.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FuelRepoImpl implements FuelRepo {
  final SupabaseClient supabaseClient;

  FuelRepoImpl(this.supabaseClient);

  @override
  Future<Either<Failure, FuelModel>> getFuelData() async {
    try {
      final response =
          await supabaseClient.from("fuel_tanks").select().single();
      log(response.toString());
      return right(FuelModel.fromJson(response));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
