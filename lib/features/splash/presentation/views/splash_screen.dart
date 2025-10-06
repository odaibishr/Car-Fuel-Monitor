import 'dart:async';

import 'package:car_monitor/core/utils/app_route.dart';
import 'package:car_monitor/features/splash/presentation/widgets/text_splsh_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../car_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      GoRouter.of(context).push(AppRoute.signInRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available height after accounting for safe area and padding
          final availableHeight = constraints.maxHeight - 32; // 16px padding top and bottom
          
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: availableHeight * 0.5, // Take 50% of available height
                        child: Image.asset(
                          Assets.assetsAssetsLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: SingleChildScrollView(
                          child: const TextSpalshInfo(
                            title: "تحكم ذكي في وقودك",
                            description:
                                '''وفر وقتك وأموالك مع  محفظتك الذكية لإدارة استهلاك الوقود بكفاءة.
تابع عمليات التعبئة، حدد أقرب محطة، واحصل على تنبيهات ذكية عند انخفاض مستوى الوقود''',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
