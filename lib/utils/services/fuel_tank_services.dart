import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class FuelTankService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// جلب بيانات خزان معين من Firestore
  Future<Map<String, dynamic>?> fetchFuelData(String tankId) async {
    try {
      DocumentSnapshot doc = await _db.collection("fuel-tanks").doc(tankId).get();

      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        log("📊 بيانات الخزان $tankId: $data");
        return data;
      } else {
        log("⚠️ الخزان $tankId غير موجود في قاعدة البيانات!");
        return null;
      }
    } catch (e, stackTrace) {
      log("❌ خطأ أثناء جلب بيانات الخزان: $e", stackTrace: stackTrace);
      rethrow; // إعادة رمي الخطأ إذا كنت تريد التعامل معه في طبقة أخرى
    }
  }
}
