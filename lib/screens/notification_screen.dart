import 'package:flutter/material.dart';
import '../components/notification_card.dart';
import '../core/theme/color_styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: ColorStyles.primaryColor,
        foregroundColor: Colors.white,
        title: const Text("الإشعارات"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              ...List.generate(
                  10,
                  (index) => Column(children: [
                        NotificationCard(
                          title: "تم تعبئة 30 لتر الى سيارتك",
                          time: "منذ 2 ساعات",
                          index: index,
                        ),
                        const SizedBox(height: 10),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
