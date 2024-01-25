import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double elapsedTime;
  final double goalTime;

  ResultScreen({required this.elapsedTime, required this.goalTime});

  @override
  Widget build(BuildContext context) {
    double difference = elapsedTime - goalTime;

    String resultText = '';
    if (difference.abs() <= 0.1) {
      resultText = '天才！！！';
    } else if (difference.abs() <= 1.0) {
      resultText = 'すごい！';
    } else if (difference.abs() <= 4.0) {
      resultText += 'まあまあだね！';
    } else {
      resultText += 'もっと頑張ろう';
    }

    String differenceText = difference >= 0
        ? '+${difference.toStringAsFixed(2)}'
        : '${difference.toStringAsFixed(2)}';

    Color circleColor = difference >= 0 ? Colors.red : Colors.blue;
    if (difference.abs() <= 0.1) {
      circleColor = Colors.pink;
    } else if (difference.abs() < 1.0) {
      circleColor = Colors.orange;
    } else if (difference.abs() > 4.0) {
      circleColor = Colors.grey; // 誤差が4秒以上の場合、灰色に変更
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('挑戦結果'),
      ),
      body: Center(
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
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
