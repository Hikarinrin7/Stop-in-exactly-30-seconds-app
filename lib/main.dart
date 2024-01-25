import 'package:flutter/material.dart';
import 'package:second30_app/screens/timer.dart';

void main() {
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
