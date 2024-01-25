import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double elapsedTime;
  final double goalTime;

  // elapsedTime（経過時間）とgoalTime（目標時間）を受け取る
  ResultScreen({required this.elapsedTime, required this.goalTime});

  @override
  Widget build(BuildContext context) {
    // 目標時間との差differenceを定義
    double difference = elapsedTime - goalTime;
    // 評価コメントresultTextを定義。abs()は絶対値
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
    // 目標との差は、+-をつけて表示するdifferenceTextに
    String differenceText = difference >= 0
        ? '+${difference.toStringAsFixed(2)}'
        : '${difference.toStringAsFixed(2)}';
    // 目標との差の表示欄である円の色circleColorを場合分け
    Color circleColor = difference >= 0 ? Colors.red : Colors.blue;
    if (difference.abs() <= 0.1) {
      circleColor = Colors.pink;
    } else if (difference.abs() < 1.0) {
      circleColor = Colors.orange;
    } else if (difference.abs() > 4.0) {
      circleColor = Colors.grey;
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
              // 小数点以下二桁に丸めるtoStringAsFixed
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'あなたの記録: ${elapsedTime.toStringAsFixed(2)}秒',
              // 小数点以下二桁に丸めるtoStringAsFixed
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
