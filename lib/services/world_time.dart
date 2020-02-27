import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the ui
  String time; // time in that loaction
  String flag; // url to a flag icon
  String url; // api location for the api
  bool isDayTime; // true or false
  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response responce =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(responce.body);
      //print(data);

      //get properties form data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      //print(offset);

      // create a date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

// set the time property in  the world time class
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

      //
    } catch (e) {
      print(e);
      time = "Could not get time at the monment";
    }
  }
}
