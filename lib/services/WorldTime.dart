import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; // the time in that location
  String url; // location url for the API endpoint
  String flag; // url to an asset flag icon
  bool isDayTime;

  WorldTime({this.location,this.url,this.flag});

  Future<void> getData() async {
    try {
      // Make a request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // Create DateTime object
      DateTime dateTime = DateTime.parse(data['utc_datetime']);
      String offset = data['utc_offset'].toString().substring(1,3);
      dateTime = dateTime.add(Duration(hours: int.parse(offset)));

      // Set time property
      isDayTime = dateTime.hour > 6 && dateTime.hour < 20 ? true :false;
      time = DateFormat.jm().format(dateTime);
    }
    catch(e) {
      print("Error: $e");
      time = 'Could not load time';
    }
  }
}


