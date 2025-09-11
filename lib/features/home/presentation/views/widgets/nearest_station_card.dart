import 'package:car_monitor/car_assets.dart';
import 'package:flutter/material.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/cart_info.dart';

class NearestStationCard extends StatelessWidget {
  const NearestStationCard({super.key, required this.distanceKm});
  final double distanceKm;

  @override
  Widget build(BuildContext context) {
    final String distText = distanceKm % 1 == 0
        ? distanceKm.toStringAsFixed(0)
        : distanceKm.toStringAsFixed(1);
    return CartInfo(
      text: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            const TextSpan(
              text: "اقرب محطة وقود تبعد",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: " $distText KM",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      image: const Image(
        image: AssetImage(Assets.assetsAssetsFuelPump),
        height: 30,
        width: 30,
        semanticLabel: 'Nearest station icon',
      ),
    );
  }
}
