import 'package:flutter/material.dart';
import 'package:worldtime/services/WorldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  WorldTime worldTime = WorldTime(location: 'Kuala Lumpur',url:'Asia/Kuala_Lumpur',flag: 'Malaysia.jpg');

  void setupWorldTime() async {
    await worldTime.getData();
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location':worldTime.location,
      'time':worldTime.time,
      'flag':worldTime.flag,
      'isDayTime':worldTime.isDayTime,
      'url':worldTime.url,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 80.0,
          ),
        ),
      ),
    );
  }
}
