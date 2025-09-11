import 'dart:async';
import 'dart:developer';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:car_monitor/components/car_info_list.dart';
import 'package:car_monitor/styles/color_styles.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

import '../styles/font_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.nearestDistance});
  final double nearestDistance;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier(50);
  double petrolProgress = 0;
  double fuelLetters = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchData(3).then((value) {
      if (value != null) {
        setState(() {
          petrolProgress = value;
        });
      }
    });
    fetchData(4).then((value) {
      if (value != null) {
        setState(() {
          fuelLetters = value;
        });
      }
    });
    startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchData(3).then((value) {
        if (value != null) {
          setState(() {
            petrolProgress = value;
          });
        }
      });
      fetchData(4).then((value) {
        if (value != null) {
          setState(() {
            fuelLetters = value;
          });
        }
      });
    });
  }

  Future<double?> fetchData(int filedNumber) async {
    String url =
        "https://api.thingspeak.com/channels/2831038/fields/$filedNumber.json?api_key=JNMQSSFLEFF6MJ6X&results=2";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data["feeds"].isNotEmpty) {
          final value =
              double.tryParse(data["feeds"].last["field$filedNumber"] ?? '');
          if (value != null) {
            log("استجابة ThingSpeak: $value");
            return value;
          }
        }
      } else {
        log("فشل في جلب البيانات: ${response.statusCode}");
      }
    } catch (e) {
      log("حدث خطأ: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: DashedCircularProgressBar.aspectRatio(
                aspectRatio: 2,
                valueNotifier: _valueNotifier,
                progress: petrolProgress,
                startAngle: 225,
                sweepAngle: 270,
                foregroundColor:
                    petrolProgress < 5 ? Colors.red : ColorStyles.primaryColor,
                backgroundColor: const Color(0xffeeeeee),
                foregroundStrokeWidth: 15,
                backgroundStrokeWidth: 15,
                animation: true,
                seekSize: 6,
                seekColor: const Color(0xffeeeeee),
                child: Center(
                  child: ValueListenableBuilder(
                      valueListenable: _valueNotifier,
                      builder: (_, double value, __) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${value.toInt()}%',
                                style: value > 15
                                    ? const TextStyle(
                                        color: ColorStyles.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40)
                                    : const TextStyle(
                                        color: ColorStyles.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40),
                              ),
                              Text(
                                'نسبة الوقود',
                                style: FontStyles.subtitle.copyWith(
                                    fontSize: 18,
                                    color: value > 15
                                        ? Colors.black
                                        : ColorStyles.primaryColor),
                              ),
                            ],
                          )),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CarInfoList(
              fuelLetters: fuelLetters,
              nearestDistance: widget.nearestDistance,
            ),
          ],
        ),
      ),
    );
  }
}
