import 'package:car_monitor/core/theme/color_styles.dart';
import 'package:car_monitor/core/theme/font_styles.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class DashedCircularProgressBarWidget extends StatelessWidget {
  const DashedCircularProgressBarWidget({super.key, required this.level});
  final double level;

  @override
  Widget build(BuildContext context) {
    return DashedCircularProgressBar.aspectRatio(
      aspectRatio: 2,
      valueNotifier: ValueNotifier(level),
      progress: level,
      startAngle: 225,
      sweepAngle: 270,
      foregroundColor: level < 5 ? Colors.red : ColorStyles.primaryColor,
      backgroundColor: const Color(0xffeeeeee),
      foregroundStrokeWidth: 15,
      backgroundStrokeWidth: 15,
      animation: true,
      seekSize: 6,
      seekColor: const Color(0xffeeeeee),
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: ValueNotifier(level),
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
                    color:
                        value > 15 ? Colors.black : ColorStyles.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
