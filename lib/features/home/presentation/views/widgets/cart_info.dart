import 'package:flutter/material.dart';

import '../../../../../core/theme/color_styles.dart';

class CartInfo extends StatelessWidget {
  final Text text;
  final Image image;
  const CartInfo({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyles.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image,
            const SizedBox(height: 5),
            text,
          ],
        ),
      ),
    );
  }
}
