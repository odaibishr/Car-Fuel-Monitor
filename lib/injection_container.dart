import 'package:car_monitor/core/api/dio_consumer.dart';
import 'package:car_monitor/features/auth/data/repos/auth_repo.dart';
import 'package:car_monitor/features/auth/data/repos/auth_repo_impl.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo_impl.dart';
import 'package:car_monitor/features/map/data/repos/map_repo.dart';
import 'package:car_monitor/features/map/data/repos/map_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt
      .registerLazySingleton<DioConsumer>(() => DioConsumer(dio: getIt<Dio>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt<SupabaseClient>()));

  getIt.registerLazySingleton<FuelRepo>(
      () => FuelRepoImpl(getIt<SupabaseClient>()));

  getIt.registerLazySingleton<MapRepository>(
      () => MapRepositoryImpl(getIt<DioConsumer>()));
}
