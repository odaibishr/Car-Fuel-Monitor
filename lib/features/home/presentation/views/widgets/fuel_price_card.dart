import 'package:car_monitor/car_assets.dart';
import 'package:flutter/material.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/cart_info.dart';

class FuelPriceCard extends StatelessWidget {
  const FuelPriceCard({super.key, this.pricePerLiter});
  final num? pricePerLiter;

  @override
  Widget build(BuildContext context) {
    final String priceText = pricePerLiter != null
        ? pricePerLiter is int
            ? pricePerLiter.toString()
            : (pricePerLiter as num).toStringAsFixed(2)
        : "—";
    return CartInfo(
      text: Text(
        "سعر اللتر $priceText ريال",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
      image: const Image(
        image: AssetImage(Assets.assetsAssetsFuelMoney),
        height: 28,
        width: 28,
        semanticLabel: 'Fuel price icon',
      ),
    );
  }
}
