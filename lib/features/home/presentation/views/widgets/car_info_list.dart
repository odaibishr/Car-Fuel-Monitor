// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:car_monitor/features/home/presentation/views/widgets/fuel_liters_card.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/fuel_price_card.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/last_refill_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:car_monitor/features/home/presentation/views/widgets/cart_info.dart';

import '../../../../../car_assets.dart';
import '../../../../../core/theme/font_styles.dart';

class CarInfoList extends StatelessWidget {
  const CarInfoList({
    super.key,
    required this.fuelLetters,
    required this.nearestDistance,
    this.lastRefillLiters,
    this.fuelPricePerLiter,
  });

  final double fuelLetters;

  final double nearestDistance;

  final double? lastRefillLiters;

  final num? fuelPricePerLiter;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 2),
          QuiltedGridTile(1, 2),
          QuiltedGridTile(1, 4),
        ],
      ),
      childrenDelegate: SliverChildListDelegate.fixed([
        FuelLitersCard(liters: fuelLetters),
        LastRefillCard(liters: lastRefillLiters),
        FuelPriceCard(pricePerLiter: fuelPricePerLiter),
        NearestStationCard(distanceKm: nearestDistance),
      ]),
    );
  }
}




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
