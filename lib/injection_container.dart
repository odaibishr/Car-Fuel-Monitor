import 'package:car_monitor/core/api/dio_consumer.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo_impl.dart';
import 'package:car_monitor/features/map/data/repos/map_repo.dart';
import 'package:car_monitor/features/map/data/repos/map_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt
      .registerLazySingleton<DioConsumer>(() => DioConsumer(dio: getIt<Dio>()));
  // Repositories
  getIt.registerLazySingleton<FuelRepo>(
      () => FuelRepoImpl(getIt<DioConsumer>()));

  getIt.registerLazySingleton<MapRepository>(
      () => MapRepositoryImpl(getIt<DioConsumer>()));
}
