import 'package:car_monitor/car_assets.dart';
import 'package:car_monitor/core/theme/font_styles.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/cart_info.dart';
import 'package:flutter/material.dart';

class FuelLitersCard extends StatelessWidget {
  const FuelLitersCard({super.key, required this.liters});
  final double liters;

  @override
  Widget build(BuildContext context) {
    final String litersText =
        liters % 1 == 0 ? liters.toStringAsFixed(0) : liters.toStringAsFixed(1);
    return CartInfo(
      text: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            const TextSpan(
              text: "الوقود باللتر \n",
              style: FontStyles.titleWhite,
            ),
            TextSpan(
              text: "$litersText ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      image: const Image(
        image: AssetImage(Assets.assetsAssetsGasCan),
        height: 40,
        width: 40,
        semanticLabel: 'Fuel liters icon',
      ),
    );
  }
}
