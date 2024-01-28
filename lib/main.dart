import 'package:flutter/material.dart';
import 'package:second30_app/screens/timer.dart';



void main() {
  //広告の配信のために追加

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
