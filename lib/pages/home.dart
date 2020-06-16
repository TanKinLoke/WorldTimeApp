import 'package:flutter/material.dart';
import 'package:worldtime/services/WorldTime.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  Map data = {};
  String bgPicture;
  Color bgColor;

  void checkTime() async {
//    await Future.delayed(Duration(milliseconds: 500),() {
//      data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
//    });
    WorldTime instance = WorldTime(
      location:data['location'],
      flag:data['flag'],
      url: data['url']
    );
    await instance.getData();
//    print(instance.time);
    if (instance.time == data['time'] || instance.location != data['location']) {
      checkTime();
    } else {
      setState(() {
        this.data = {
          'location':instance.location,
          'time':instance.time,
          'flag':instance.flag,
          'isDayTime':instance.isDayTime,
          'url':instance.url,
        };
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    bgPicture = data['isDayTime'] ? 'day.jpg':'night.jpg';
    bgColor = data['isDayTime'] ? Colors.blue[300]:Colors.indigo;
    checkTime();
    print(data);
    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgPicture'),
                fit: BoxFit.fill,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[300],
                      ),
                      label: Text(
                        'Edit location',
                        style: TextStyle(
                        color: Colors.grey[300],
                        ),
                      ),
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'location':result['location'],
                            'time':result['time'],
                            'flag':result['flag'],
                            'isDayTime':result['isDayTime'],
                            'url':result['url'],
                          };
                        });
//                        checkTime(data);
                      }
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          letterSpacing: 2.0
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data['time'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 66.0,
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
