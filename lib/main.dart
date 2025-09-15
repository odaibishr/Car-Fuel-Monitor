import 'package:car_monitor/core/utils/app_route.dart';
import 'package:car_monitor/features/app/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:car_monitor/features/auth/data/repos/auth_repo.dart';
import 'package:car_monitor/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:car_monitor/features/home/data/repos/fuel_repo.dart';
import 'package:car_monitor/features/home/presentation/manager/fuel_cubit/fuel_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/theme/color_styles.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  di.init();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
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
          create: (context) => FuelCubit(di.getIt<FuelRepo>())..getFuelData(),
        ),
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(di.getIt<AuthRepo>()),
        ),
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
