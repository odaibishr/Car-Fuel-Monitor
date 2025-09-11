// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/color_styles.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
    required this.loaderSize,
  });
  
  final double loaderSize;

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: ColorStyles.primaryColor,
      size: loaderSize,
    );
  }
}
