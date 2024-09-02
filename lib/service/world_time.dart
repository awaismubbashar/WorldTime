import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String url;
  String time = '';
  String flag;
  bool isDayTime = true;

  WorldTime({required this.location, required this.url, required this.flag});

  Future<void> getWorldTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String utcOffset = data['utc_offset'];
      utcOffset = utcOffset.substring(1, 3);
      String dateTime = data['datetime'];

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(utcOffset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = "Time not found";
    }
  }
}

//Europe/London
