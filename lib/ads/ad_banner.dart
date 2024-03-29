import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//AdBannerというクラス（ウィジェット）を定義。AdSizeを必須パラメータとしてとる
class AdBanner extends StatefulWidget {
  const AdBanner({
    Key? key,
    required this.size,
  }) : super(key: key);
  final AdSize size;

  @override
  _AdBannerState createState() => _AdBannerState();
}

//_AdBannerStateクラスは、
// _createBannerメソッド（下で定義）を使用して広告を生成し、状態を管理
class _AdBannerState extends State<AdBanner> {
  late BannerAd banner;

  //initStateは、ウィジェットを初期化時に生成
  @override
  void initState() {
    super.initState();
    // AdMobの初期化
    MobileAds.instance.initialize();
    banner = _createBanner(widget.size);
  }
  //disposeは、ウィジェットを廃棄時に解放
  @override
  void dispose() {
    banner.dispose();
    super.dispose();
  }

  //生成された広告をAdWidgetでラップして、親のSizedBoxに配置
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: banner.size.width.toDouble(),
      height: banner.size.height.toDouble(),
      child: AdWidget(ad: banner),
    );
  }

  String get bannerAdUnitId {
    if (kDebugMode) {
      // return BannerAd.testAdUnitId;  // Deprecatedになった
      // 公式ドキュメントで公開されているデモ広告ユニットIDを指定する
      // https://developers.google.com/admob/android/test-ads?hl=ja
      // https://developers.google.com/admob/ios/test-ads?hl=ja
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }

    if (Platform.isAndroid) {
      return 'ca-app-pub-6131383135644612/9013501304'; // ここに発行したAndroid用の広告IDを設定
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6131383135644612/9585326880'; // ここに発行したiOS用の広告IDを設定
    } else {
      // return BannerAd.testAdUnitId;  // Deprecatedになった
      // https://developers.google.com/admob/android/test-ads?hl=ja
      // AndroidのテストIDを暫定で返却しておく
      return 'ca-app-pub-3940256099942544/6300978111';
    }
  }

  //指定されたサイズとユニットIDでBannerAdを生成する、_createBannerメソッドを定義
  //BannerAdListenerを使用して、広告の読み込みエラー時には広告を解放
  BannerAd _createBanner(AdSize size) {
    return BannerAd(
      size: size,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          banner.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }
}
