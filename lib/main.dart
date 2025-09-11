import 'package:car_monitor/core/api/dio_consumer.dart';
import 'package:car_monitor/core/utils/app_route.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo_impl.dart';
import 'package:car_monitor/features/home/presentation/manager/fuel_cubit/fuel_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'core/theme/color_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FuelCubit(FuelRepoImpl(DioConsumer(dio: Dio())))..getFuelData(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
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
