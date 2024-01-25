import 'dart:ui';
import 'package:flutter/material.dart';
import 'result.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  bool _isRunning = false;

  // 目標時間の設定リスト
  List<int> goalTimes = [10, 20, 30, 60];
  int selectedGoalTimeIndex = 2; // 初期選択は30秒

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    // タイマーが経過時間を定期的に更新する
    _timer = Timer.periodic(Duration(milliseconds: 10), (Timer timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  void _toggleStopwatch() {
    // ストップウォッチの開始/停止を切り替える
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    } else {
      _stopwatch.start();
      _startStopwatch();
    }
    _isRunning = !_isRunning;
  }

  void _resetStopwatch() {
    // ストップウォッチをリセットする
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    }
    _stopwatch.reset();
    setState(() {});
    _isRunning = false;
  }

  void _navigateToResultScreen() {
    // 経過時間が0秒以上の場合に ResultScreen に遷移する
    if (_stopwatch.elapsed.inSeconds > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(
                elapsedTime: _stopwatch.elapsed.inMilliseconds.toDouble() /
                    1000,
                goalTime: goalTimes[selectedGoalTimeIndex].toDouble(),
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ぴったりで止めろ！'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SizedBox(height: 20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('目標時間：'),
          SizedBox(width: 10.0),
          DropdownButton<int>(
            value: selectedGoalTimeIndex,
            items: goalTimes
                .map((time) =>
                DropdownMenuItem<int>(
                  value: goalTimes.indexOf(time),
                  child: Text('$time秒'),
                ))
                .toList(),
            onChanged: (index) {
              // 選択された目標時間のインデックスを更新
              setState(() {
                selectedGoalTimeIndex = index!;
              });
            },
          ),
        ],
      ),
      SizedBox(height: 20.0),
      Container(
        width: 350.0,
        height: 100.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black),
        ),
        child: Center(
          child: Text(
            _stopwatch.elapsed.inSeconds >= 4 ? '？' : formatStopwatchTime(),
            style: TextStyle(
              fontSize: 48.0,
              fontFeatures: [FontFeature.tabularFigures()], // ぶれないように
            ),
          ),
        ),
      ),
      SizedBox(height: 50.0),
      Container(
        width: 200.0,
        height: 200.0,
        child: ElevatedButton(
          onPressed: _toggleStopwatch,
          child: Text(
            _isRunning ? 'Stop' : 'Start',
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
      SizedBox(height: 50.0),
      Text(
        _isRunning
            ? '測定中...'
            : _stopwatch.elapsed.inSeconds == 0
            ? 'Startを押して開始'
            : '結果を確認してみましょう！',
        style: TextStyle(fontSize: 18.0),
      ),
      SizedBox(height: 50.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _resetStopwatch,
            child: Text(
              'Reset',
              style: TextStyle(fontSize: 18.0),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150.0, 60.0),
            ),
          ),
          ElevatedButton(
            onPressed: _stopwatch.elapsed.inSeconds == 0
                ? null
                : _isRunning
                ? null
                : _navigateToResultScreen,
            child: Text(
              'Result→',
              style: TextStyle(fontSize: 18.0),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150.0, 60.0),
            ),
          ),
        ],
      ),
      FlutterLogo(
        size: 100,
        style: FlutterLogoStyle.horizontal,
      )
      ],
    ),);
  }

  String formatStopwatchTime() {
    // ストップウォッチの経過時間をフォーマットして返す
    final int decimalSeconds =
    ((_stopwatch.elapsedMilliseconds / 10) % 100).truncate();
    final int seconds = (_stopwatch.elapsedMilliseconds ~/ 1000) % 60;
    final int minutes = (_stopwatch.elapsedMilliseconds ~/ 60000) % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}.${decimalSeconds
        .toString().padLeft(2, '0')}';
  }
}
