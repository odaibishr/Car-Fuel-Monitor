import 'package:car_monitor/features/map/data/repos/map_repo.dart';
import 'package:car_monitor/features/map/data/repos/map_repo_impl.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void init() {
  // Repositories
  getIt.registerLazySingleton<MapRepository>(() => MapRepositoryImpl());
}
