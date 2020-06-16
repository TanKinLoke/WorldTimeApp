import 'package:flutter/material.dart';
import 'package:worldtime/pages/loading.dart';
import 'package:worldtime/pages/ChooseLocation.dart';
import 'package:worldtime/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home':(context) => home(),
      '/location':(context) => ChooseLocation(),
    },
  ));
}