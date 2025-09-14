import 'package:car_monitor/core/api/dio_consumer.dart';
import 'package:car_monitor/core/utils/app_route.dart';
import 'package:car_monitor/features/app/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo_impl.dart';
import 'package:car_monitor/features/home/presentation/manager/fuel_cubit/fuel_cubit.dart';
import 'package:car_monitor/features/map/data/repos/map_repo_impl.dart';
import 'package:car_monitor/features/map/presentation/manager/map_street_cubit/map_street_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'core/theme/color_styles.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  dotenv.load(fileName: ".env");
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FuelCubit(FuelRepoImpl(DioConsumer(dio: Dio())))..getFuelData(),
        ),
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
<<<<<<< HEAD
        // BlocProvider(
        //     create: (context) => MapCubit(
        //         mapRepository: di.getIt<MapRepository>(),
        //         updateDistance: (double distance) {
        //           log('Distance to nearest station: $distance km');
        //         })),
=======
        BlocProvider(
          create: (context) =>
              MapStreetCubit(MapRepoImpl(DioConsumer(dio: Dio())))
                ..getCurrentLocation()..getNearbyFuelStations(),
        ),
>>>>>>> f6b0278cc2da0d80fd33ddb76eae8343a9fdd8a4
      ],
      child: MaterialApp.router(
        title: 'Car Fuel Monitor',
        routerConfig: AppRoute.router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("ar", "AE"),
        ],
        theme: ThemeData(
          fontFamily: "Cairo",
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorStyles.primaryColor),
          useMaterial3: true,
        ),
      ),
    );
  }
}
