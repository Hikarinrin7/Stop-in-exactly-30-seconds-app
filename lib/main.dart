import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:second30_app/screens/timer.dart';
import 'package:second30_app/ads/ad_banner.dart';

void main() {
  //広告の配信のために追加
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
