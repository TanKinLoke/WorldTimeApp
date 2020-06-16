import 'package:flutter/material.dart';
import 'package:worldtime/services/WorldTime.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> worldTime = [
    WorldTime(location: 'Kuala Lumpur',url:'Asia/Kuala_Lumpur',flag: 'Malaysia.jpg'),
    WorldTime(location: 'New York',url:'America/New_York',flag: 'USA.png'),
    WorldTime(location: 'Seoul',url:'Asia/Seoul',flag: 'Seoul.png'),
    WorldTime(location: 'Jakarta',url:'Asia/Jakarta',flag: 'Thailand.png'),
    WorldTime(location: 'London',url:'Europe/London',flag: 'UK.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = worldTime[index];
    await instance.getData();
    print(instance.location);
    Navigator.pop(context,{
      'location':instance.location,
      'time':instance.time,
      'flag':instance.flag,
      'isDayTime':instance.isDayTime,
      'url':instance.url,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Location'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: worldTime.length,
        itemBuilder: (context,index) {
          return Card(
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/${worldTime[index].flag}'),
              ),
              title: Text(worldTime[index].location),
            ),
          );
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
