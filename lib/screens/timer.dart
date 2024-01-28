import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:second30_app/ads/ad_banner.dart';
import 'result.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // Stopwatchオブジェクトの宣言・タイマーの実行状態を保持する変数_isRunningの定義
  // late：変数が後で初期化されることを示す。
  late Stopwatch _stopwatch;
  bool _isRunning = false;

  //目標時間の設定リストgoalTimes
  //初期値30秒
  List<int> goalTimes = [10, 20, 30, 60];
  int selectedGoalTimeIndex = 2;

  // ドロップダウンメニューに使うリスト作成（
  List<DropdownMenuItem<int>> buildDropdownMenuItems() {
    return goalTimes.map((time) {
      return DropdownMenuItem<int>(
        child: Text('$time秒'),
        value: goalTimes.indexOf(time),
      );
    }).toList();
  }

  // initState()：State オブジェクトがウィジェットツリーに追加されたときに呼び出される
  // ストップウォッチの初期化
  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  // タイマーが経過時間を定期的に更新する
  void _startStopwatch() {
    const duration = Duration(milliseconds: 10);
    void updateUI(Timer timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    }

    Timer.periodic(duration, updateUI);
  }

  // ストップウォッチの経過時間を表示する文字列に変換
  // ~/は整数除算を意味し、小数点以下を切り捨てるらしい
  // 2567ミリ秒なら、567→56
  String formatStopwatchTime() {
    final int decimalSeconds = _stopwatch.elapsed.inMilliseconds % 1000 ~/ 10;
    final int seconds = (_stopwatch.elapsedMilliseconds ~/ 1000) % 100;

    return '${seconds.toString().padLeft(2, '0')}.${decimalSeconds.toString().padLeft(2, '0')}';
  }

  // ストップウォッチの開始/停止を切り替える_toggleStopwatch
  void _toggleStopwatch() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
        _startStopwatch();
      }
      _isRunning = !_isRunning;
    });
  }

  // ストップウォッチをリセットする_resetStopwatch
  void _resetStopwatch() {
    setState(() {
      _stopwatch.stop();
      _stopwatch.reset();
      _isRunning = false;
    });
  }

  // 結果画面に遷移する_navigateToResultScreen
  // elapsedTime（経過時間）とgoalTime（目標時間）を渡す
  void _navigateToResultScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ResultScreen(
            elapsedTime: _stopwatch.elapsed.inMilliseconds.toDouble() / 1000,
            goalTime: goalTimes[selectedGoalTimeIndex].toDouble(),
          );
        },
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('遊び方'),
          content: Container(
            width: 200,
            height: 180,
            child: ListView(
              children: [
                Text('① 目標時間を設定します。'),
                Text('② Startボタンを押します。'),
                Text('③ ちょうど30秒だと思ったらStopボタンを押します。'),
                Text('④ Resultボタンを押すと、結果が見られます。'),
                Text('★ 誤差が0.1秒以内になると...?!'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('閉じる'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text(
          'ぴったりで止めろ！',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // 電球アイコン
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {
              _showPopup(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 目標時間設定
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('目標時間：'),
              SizedBox(width: 10.0),
              DropdownButton<int>(
                value: selectedGoalTimeIndex,
                items: buildDropdownMenuItems(),
                onChanged: (index) {
                  setState(() {
                    selectedGoalTimeIndex = index!;
                  });
                },
              ),
            ],
          ),
          // 経過時間表示欄
          Container(
            width: 300.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.black),
            ),
            child: Center(
              child: Text(
                _stopwatch.elapsed.inSeconds >= 4 ? '？' : formatStopwatchTime(),
                style: TextStyle(
                  fontSize: 48.0,
                  fontFeatures: [FontFeature.tabularFigures()], // 等幅フォント
                ),
              ),
            ),
          ),
          // スタート・ストップボタン
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
          // 案内テキスト
          Text(
            _isRunning
                ? '測定中...'
                : _stopwatch.elapsed.inSeconds == 0
                    ? 'Startを押して開始'
                    : '結果を確認してみましょう！',
            style: TextStyle(fontSize: 18.0),
          ),
          // リセットボタンと結果画面遷移ボタン
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // リセットボタン
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
              // 結果画面遷移ボタン
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
          //広告！！！！
          FutureBuilder(
            future: AdSize.getAnchoredAdaptiveBannerAdSize(Orientation.portrait,
                MediaQuery.of(context).size.width.truncate()),
            builder: (
              BuildContext context,
              AsyncSnapshot<AnchoredAdaptiveBannerAdSize?> snapshot,
            ) {
              if (snapshot.hasData) {
                //広告サイズが取得できた場合
                final data = snapshot.data;
                if (data != null) {
                  return Container(
                    height: 70,
                    color: Colors.white70,
                    child: AdBanner(size: data),
                  );
                } else {
                  // 広告サイズが取得できなかった場合
                  return Container(
                    height: 70,
                    color: Colors.white70,
                    child: Text("あれ、広告が取得できなかったよ…"),
                  );
                }
              } else {
                return Container(
                  height: 70,
                  color: Colors.white70,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
