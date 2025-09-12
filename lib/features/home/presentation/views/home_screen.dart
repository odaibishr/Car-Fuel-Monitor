import 'package:car_monitor/features/home/presentation/views/widgets/car_info_list.dart';
import 'package:car_monitor/core/widgets/custom_loader.dart';
import 'package:car_monitor/features/home/presentation/manager/fuel_cubit/fuel_cubit.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/dashed_circle_progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<FuelCubit, FuelState>(
              builder: (context, state) {
                if (state is FuelSuccess) {
                  return Column(children: [
                    DashedCircularProgressBarWidget(
                        level: state.fuelModel.level!),
                    const SizedBox(height: 20),
                    CarInfoList(
                      fuelLetters: state.fuelModel.letters!,
                      nearestDistance: 11,
                    )
                  ]);
                } else if (state is FuelError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: CustomLoader(loaderSize: 50));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
