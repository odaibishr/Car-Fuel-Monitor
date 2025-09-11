import 'package:car_monitor/features/home/presentation/views/home_screen.dart';
import 'package:car_monitor/features/splash/presentation/views/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static const String splashRoute = '/';
  static const String homeRoute = '/homeView';

  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: splashRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: homeRoute,
      builder: (context, state) => const HomeScreen(),
    ),
  ]);
}
