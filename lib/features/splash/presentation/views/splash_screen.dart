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
      GoRouter.of(context).push(AppRoute.homeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    Assets.assetsAssetsLogo,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              const TextSpalshInfo(
                title: "تحكم ذكي في وقودك",
                description:
                    '''وفر وقتك وأموالك مع  محفظتك الذكية لإدارة استهلاك الوقود بكفاءة.
تابع عمليات التعبئة، حدد أقرب محطة، واحصل على تنبيهات ذكية عند انخفاض مستوى الوقود''',
                // button: Transform.scale(
                //   scale: 1.8,
                //   child: const CustomLoader(),
                // ),
                // press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
