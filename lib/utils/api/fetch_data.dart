import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ThingSpeakService {
  final String channelId = "2831038"; // معرف القناة
  
  final String readApiKey = "WDKNWS6ITABOA13U"; // مفتاح القراءة (إن وُجد)
  final String writeApiKey = "JNMQSSFLEFF6MJ6X"; // مفتاح الكتابة الخاص بالقناة

  ThingSpeakService(
    required
  );

   Future<bool> sendData(String field1Value) async {
    final String url =
        "https://api.thingspeak.com/update?api_key=$writeApiKey&field1=$field1Value";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && response.body != "0") {
        log("تم إرسال البيانات بنجاح!");
        return true;
      } else {
        log("فشل الإرسال! الكود: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("خطأ أثناء الإرسال: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchData() async {
    final String url =
        "https://api.thingspeak.com/channels/$channelId/fields/1.json?results=1&api_key=$readApiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return data["feeds"].isNotEmpty ? data["feeds"][0] : null;
      } else {
        log("فشل في جلب البيانات: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("حدث خطأ: $e");
      return null;
    }
  }
}
