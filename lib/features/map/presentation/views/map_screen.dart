import 'package:car_monitor/core/theme/color_styles.dart';
import 'package:car_monitor/core/widgets/custom_loader.dart';
import 'package:car_monitor/features/map/data/repos/map_repo.dart';
import 'package:car_monitor/features/map/presentation/manager/map_street_cubit/map_street_cubit.dart';
import 'package:car_monitor/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final Function(double) updateDistance;

  const MapScreen({super.key, required this.updateDistance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الخريطة',
          style: TextStyle(color: ColorStyles.whiteColor),
        ),
        backgroundColor: ColorStyles.primaryColor,
      ),
      body: BlocProvider<MapCubit>(
        create: (context) {
          
          return MapCubit(
            mapRepository: di.getIt<MapRepository>(),
            updateDistance: updateDistance,
          )
            ..getCurrentLocation()
            ..startListeningToLocation();
        },
        child: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            if (state is MapInitial || state is MapLoading) {
              return const Center(child: CustomLoader(loaderSize: 40));
            }

            if (state is MapError) {
              return Center(child: Text(state.message));
            }

            if (state is MapLocationLoaded) {
              return FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    state.location.latitude!,
                    state.location.longitude!,
                  ),
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: state.markers),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: state.routePoints,
                        strokeWidth: 4.0,
                        color: ColorStyles.primaryColor,
                      ),
                    ],
                  ),
                ],
              );
            }

            return const Center(child: Text('حالة غير معروفة'));
          },
        ),
      ),
    );
  }
}
