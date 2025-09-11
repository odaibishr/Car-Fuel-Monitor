import 'package:car_monitor/car_assets.dart';
import 'package:flutter/material.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/cart_info.dart';

class LastRefillCard extends StatelessWidget {
  const LastRefillCard({super.key, this.liters});
  final double? liters;

  @override
  Widget build(BuildContext context) {
    final String valueText = liters == null
        ? "—"
        : (liters! % 1 == 0
            ? liters!.toStringAsFixed(0)
            : liters!.toStringAsFixed(1));
    return CartInfo(
      text: Text(
        "آخر تعبئة: $valueText لتر",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      image: const Image(
        image: AssetImage(Assets.assetsAssetsGasoline),
        height: 28,
        width: 28,
        semanticLabel: 'Last refill icon',
      ),
    );
  }
}
