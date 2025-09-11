import 'dart:convert';
import 'dart:developer';
import 'package:car_monitor/core/widgets/custom_loader.dart';
import 'package:car_monitor/components/custom_text_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/theme/color_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double fuelTankCapacity = 0.0; // liters of fuel tank
  double reserveFuelTank = 0.0; // liters of reserve tank
  final String writeApiKey = "JNMQSSFLEFF6MJ6X"; // مفتاح الكتابة الخاص بالقناة
  bool isLoading = true; // متغير لحالة التحميل

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tankCapacityController = TextEditingController();
  final TextEditingController _reserveCapacityController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        if (value != null) {
          _tankCapacityController.text = value.toString();
        }
        isLoading = false;
      });
    });
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      chageTankCapacity(double.parse(_tankCapacityController.text));
      changeReserveTankCapacity(double.parse(_reserveCapacityController.text));

      if (reserveFuelTank >= fuelTankCapacity) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يجب أن تكون سعة الاحتياطي أقل من سعة الخزان الكلية'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'تم إدخال البيانات بنجاح: سعة الخزان $fuelTankCapacity لتر، سعة الاحتياطي $reserveFuelTank لتر'),
            backgroundColor: ColorStyles.primaryColor.withOpacity(0.8),
          ),
        );
      }
    }

    _formKey.currentState?.save();
    await updateFuelData(fuelTankCapacity, reserveFuelTank);
  }

  Future<String?> fetchData() async {
    const String url =
        "https://api.thingspeak.com/channels/2831038/fields/1.json?api_key=JNMQSSFLEFF6MJ6X&results=2";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        log("استجابة ThingSpeak: ${data["feeds"].last["field1"]}");
        return data["feeds"].isNotEmpty ? data["feeds"].last["field1"] : null;
      } else {
        log("فشل في جلب البيانات: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("حدث خطأ: $e");
      return null;
    }
  }

  Future<void> updateFuelData(double percentage, double liters) async {
    try {
      // الحصول على مرجع المجموعة 'fuel-tanks'
      CollectionReference fuelTanks =
          FirebaseFirestore.instance.collection('fuel-tanks');

      // إنشاء مستند جديد مع البيانات المحدثة
      await fuelTanks.doc('tank_1').set({
        'percentage': percentage,
        'liters': liters,
        'timestamp':
            FieldValue.serverTimestamp(), // إضافة الطابع الزمني للتحديث
      });

      log("✅ تم تحديث بيانات الوقود بنجاح: نسبة الوقود: $percentage٪، اللترات: $liters L");
    } catch (e) {
      log("❌ حدث خطأ أثناء محاولة تحديث بيانات الوقود: $e");
    }
  }

  Future<bool> sendData(String field1Value) async {
    final String url =
        "https://api.thingspeak.com/update?api_key=WDKNWS6ITABOA13U&field1=$field1Value";

    try {
      final response = await http.get(Uri.parse(url));

      log("استجابة ThingSpeak: ${response.body}"); // طباعة الاستجابة للتحقق منها

      if (response.statusCode == 200) {
        if (response.body.trim() != "0") {
          log("تم إرسال البيانات بنجاح! رقم الإدخال: ${response.body}");
          return true;
        } else {
          log("فشل الإرسال! قد يكون هناك حد زمني بين الطلبات.");
          return false;
        }
      } else {
        log("فشل الإرسال! رمز الحالة: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("خطأ أثناء الإرسال: $e");
      return false;
    }
  }

  // this function to change the tank capacity
  void chageTankCapacity(double tankCapacity) {
    setState(() {
      fuelTankCapacity = tankCapacity;
      log('fuelTankCapacity: $fuelTankCapacity');
    });
  }

  // this function to change the reserve tank
  void changeReserveTankCapacity(double reserveTank) {
    setState(() {
      reserveFuelTank = reserveTank;
      log('reserveFuelTank: $reserveFuelTank');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.primaryColor,
        title: const Text(
          "الإعدادات",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.arrow_right,
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CustomLoader(loaderSize: 40)) // عرض اللودر أثناء الجلب
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سعة الخزان',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8.0),
                    CustomTextField(
                      controller: _tankCapacityController,
                      hintText: fuelTankCapacity == 0.0
                          ? 'أدخل سعة خزان الوقود باللتر'
                          : fuelTankCapacity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال سعة الخزان';
                        }
                        if (double.tryParse(value) == null) {
                          return 'يرجى إدخال رقم صالح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'سعة الاحتياطي',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8.0),
                    CustomTextField(
                      controller: _reserveCapacityController,
                      hintText: 'أدخل سعة الاحتياطي باللتر',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال سعة الاحتياطي';
                        }
                        if (double.tryParse(value) == null) {
                          return 'يرجى إدخال رقم صالح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyles.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          'إرسال البيانات',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
