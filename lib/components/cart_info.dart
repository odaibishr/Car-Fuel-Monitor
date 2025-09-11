// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../styles/color_styles.dart';

class CartInfo extends StatefulWidget {
  

  final Text text;
  final Image image;
  const CartInfo({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  State<CartInfo> createState() => _CartInfoState();
}

class _CartInfoState extends State<CartInfo> {
 
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
            widget.image,
            const SizedBox(height: 5),
            widget.text,
          ],
        ),
      ),
    );
  }
}
