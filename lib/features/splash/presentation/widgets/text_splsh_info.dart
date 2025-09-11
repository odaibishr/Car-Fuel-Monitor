import 'package:car_monitor/core/widgets/custom_loader.dart';
import 'package:flutter/material.dart';

class TextSpalshInfo extends StatelessWidget {
  const TextSpalshInfo({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const CustomLoader(loaderSize: 30),
            ]),
      ),
    );
  }
}
