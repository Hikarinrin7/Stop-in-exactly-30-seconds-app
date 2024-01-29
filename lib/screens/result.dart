import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:second30_app/ads/ad_banner.dart';

class ResultScreen extends StatelessWidget {
  final double elapsedTime;
  final double goalTime;

  ResultScreen({required this.elapsedTime, required this.goalTime});

  @override
  Widget build(BuildContext context) {
    double difference = elapsedTime - goalTime;
    String resultText = '';
    if (difference.abs() <= 0.05) {
      resultText = '天才！！！';
    } else if (difference.abs() <= 0.8) {
      resultText = 'すごい！';
    } else if (difference.abs() <= 3.0) {
      resultText += 'まあまあだね！';
    } else {
      resultText += 'もっと頑張ろう';
    }

    String differenceText = difference >= 0
        ? '+${difference.toStringAsFixed(2)}'
        : '${difference.toStringAsFixed(2)}';

    Color circleColor = difference >= 0 ? Colors.red : Colors.blue;
    if (difference.abs() <= 0.05) {
      circleColor = Colors.pink;
    } else if (difference.abs() < 0.8) {
      circleColor = Colors.orange;
    } else if (difference.abs() > 3.0) {
      circleColor = Colors.grey;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text(
          '挑戦結果',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '目標時間: ${goalTime.toStringAsFixed(2)}秒',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'あなたの記録: ${elapsedTime.toStringAsFixed(2)}秒',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circleColor,
                    ),
                    padding: EdgeInsets.all(80.0),
                    child: Text(
                      '$differenceText秒',
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    resultText,
                    style:
                    TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            //広告
            Container(
              alignment: Alignment.bottomCenter,
              height: 70,
              color: Colors.white70,
              child: FutureBuilder(
                future: AdSize.getAnchoredAdaptiveBannerAdSize(
                  Orientation.portrait,
                  MediaQuery.of(context).size.width.truncate(),
                ),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<AnchoredAdaptiveBannerAdSize?> snapshot,
                    ) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    if (data != null) {
                      return AdBanner(size: data);
                    } else {
                      return Text("あれ、広告が取得できなかったよ…");
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
