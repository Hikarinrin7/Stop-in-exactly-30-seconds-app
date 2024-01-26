# 狙え！ぴったり30秒

ちょうど30秒でストップウォッチを止めることを目指すゲームです。

どれくらいぴったりかによって評価が変わります。

秒数は10, 20, 30, 60秒から選択できます。

誤差0.1秒以内になると…？！

## 遊び方

スタートボタンを押します。

30秒経ったと思ったらストップボタンを押します。

右下のresult→ボタンから結果を確認しましょう。

resetすると何度でも遊べます。

## 工夫したところ

・秒数表示がぶれない。

・開始前とカウントアップ中は、結果への遷移ボタンが押せなくなる。

・画面サイズが変わってもレイアウトが崩れない。

### 技術要件

・マルチスクリーンであること(=画面遷移があること)

・Row Widget が使われていること

・Column Widget が使われていること

・Stateful Widget、setState() が使われていること

・https://docs.flutter.dev/reference/widgets より本授業で取り扱っていないWidgetを自身で調べ、実際に使ってみること

### 使ったWidget

・DropdownButton：https://api.flutter.dev/flutter/material/DropdownButton-class.html

・FlutterLogo：https://api.flutter.dev/flutter/material/FlutterLogo-class.html

### その他

プログラミング初心者なので、何のコードなのかのメモ書きが多く残っています。