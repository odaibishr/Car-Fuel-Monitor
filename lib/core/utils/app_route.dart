import 'package:car_monitor/features/app/presentation/views/bottom_nav_bar.dart';
import 'package:car_monitor/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:car_monitor/features/auth/presentation/views/sign_in_screen.dart';
import 'package:car_monitor/features/auth/presentation/views/sign_up_screen.dart';
import 'package:car_monitor/features/home/presentation/views/home_screen.dart';
import 'package:car_monitor/features/map/presentation/views/map_screen.dart';
import 'package:car_monitor/features/splash/presentation/views/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  final AuthCubit authCubit;

  AppRoute({required this.authCubit});

  static const String splashRoute = '/';
  static const String homeRoute = '/homeView';
  static const String bottomNavRoute = '/bottomNavView';
  static const String mapRoute = '/mapView';
  static const String signInRoute = '/signInView';
  static const String signUpRoute = '/signUpView';

  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: splashRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: homeRoute,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: bottomNavRoute,
      builder: (context, state) => const BottomNavBar(),
    ),
    GoRoute(
        path: mapRoute,
        builder: (context, state) =>
            MapScreen(updateDistance: (double nearestStationDistance) {})),
    GoRoute(
      path: signInRoute,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: signUpRoute,
      builder: (context, state) => const SignUpScreen(),
    ),
  ]);
}
