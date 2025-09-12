import 'dart:developer';

import 'package:car_monitor/features/map/presentation/manager/map_street_cubit/map_street_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocBuilder<MapStreetCubit, MapStreetState>(
        builder: (context, state) {
          if(state is MapStreetSuccess){
            return const Center(
              child: Text("Map"),
            );
          }
          return const Center(
            child: Text("Map"),
          );
        },
      ),
    );
  }
}
