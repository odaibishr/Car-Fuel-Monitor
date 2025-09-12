// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:car_monitor/features/home/presentation/views/widgets/fuel_liters_card.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/fuel_price_card.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/last_refill_card.dart';
import 'package:car_monitor/features/home/presentation/views/widgets/nearest_station_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';



class CarInfoList extends StatelessWidget {
  const CarInfoList({
    super.key,
    required this.fuelLetters,
    required this.nearestDistance,
    this.lastRefillLiters = 15,
    this.fuelPricePerLiter = 450,
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




