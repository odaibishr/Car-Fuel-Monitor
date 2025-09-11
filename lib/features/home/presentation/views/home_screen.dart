import 'package:car_monitor/components/car_info_list.dart';
import 'package:car_monitor/core/theme/color_styles.dart';
import 'package:car_monitor/core/theme/font_styles.dart';
import 'package:car_monitor/core/widgets/custom_loader.dart';
import 'package:car_monitor/features/home/presentation/manager/fuel_cubit/fuel_cubit.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
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
                    DashedCircularProgressBar.aspectRatio(
                      aspectRatio: 2,
                      valueNotifier: ValueNotifier(state.fuelModel.level!),
                      progress: state.fuelModel.level!,
                      startAngle: 225,
                      sweepAngle: 270,
                      foregroundColor: state.fuelModel.level! < 5
                          ? Colors.red
                          : ColorStyles.primaryColor,
                      backgroundColor: const Color(0xffeeeeee),
                      foregroundStrokeWidth: 15,
                      backgroundStrokeWidth: 15,
                      animation: true,
                      seekSize: 6,
                      seekColor: const Color(0xffeeeeee),
                      child: Center(
                        child: ValueListenableBuilder(
                          valueListenable:
                              ValueNotifier(state.fuelModel.level!),
                          builder: (_, double value, __) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${value.toInt()}%',
                                style: value > 15
                                    ? const TextStyle(
                                        color: ColorStyles.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40)
                                    : const TextStyle(
                                        color: ColorStyles.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40),
                              ),
                              Text(
                                'نسبة الوقود',
                                style: FontStyles.subtitle.copyWith(
                                    fontSize: 18,
                                    color: value > 15
                                        ? Colors.black
                                        : ColorStyles.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
