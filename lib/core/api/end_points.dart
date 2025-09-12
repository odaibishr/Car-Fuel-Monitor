import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static  String channelId = dotenv.env['THINGSPEAK_CHANNEL_ID']!;
  static String apiKey = dotenv.env['THINGSPEAK_API_KEY']!;

  static  String baserUrl =
      "https://api.thingspeak.com/channels/$channelId/";
}
