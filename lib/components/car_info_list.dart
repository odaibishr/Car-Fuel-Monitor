// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:car_monitor/components/cart_info.dart';

import '../car_assets.dart';
import '../core/theme/font_styles.dart';

// ignore: must_be_immutable
class CarInfoList extends StatelessWidget {
  CarInfoList({
    super.key,
    required this.fuelLetters,
    required this.nearestDistance,
  });
  final double fuelLetters;
  final double nearestDistance;

  List<Map<String, dynamic>> contents = [
    {
      'image': const Image(
          image: AssetImage(Assets.assetsAssetsFuelPump),
          height: 40,
          width: 40),
      'text': const Text(
        "اخر تعبئة: 20 لتر",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
    },
    {
      'image': const Image(
          image: AssetImage(Assets.assetsAssetsGasoline),
          height: 28,
          width: 28),
      'text': const Text(
        "اخر تعبئة: 20 لتر",
        style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    },
    {
      'image': const Image(
          image: AssetImage(Assets.assetsAssetsFuelMoney),
          height: 28,
          width: 28),
      'text': const Text(
        "سعر اللتر ${475} ريال",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    },
    const {
      'image': Image(
          image: AssetImage(Assets.assetsAssetsFuelPump),
          height: 30,
          width: 30),
      'text': Text(
        "اقرب محطة وقود ${1}k",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
        shrinkWrap: true,
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
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => index == 0
              ? CartInfo(
                  text: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "الوقود باللتر \n",
                          style: FontStyles.titleWhite, // تنسيق النص الأول
                        ),
                        TextSpan(
                          text: "$fuelLetters ", // قيمة fuelLetters
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
                  ),
                )
              : index == 3
                  ? CartInfo(
                      text: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "اقرب محطة وقود تبعد",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ), // تنسيق النص الأول
                            ),
                            TextSpan(
                              text:
                                  " $nearestDistance KM", // قيمة nearestDistance
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
                      ),
                    )
                  : CartInfo(
                      text: contents[index]["text"],
                      image: contents[index]["image"],
                    ),
          childCount: 4,
        ));
  }
}
