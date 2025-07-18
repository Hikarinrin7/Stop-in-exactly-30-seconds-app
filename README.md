# 狙え！ぴったり30秒

ちょうど30秒でストップウォッチを止めることを目指すゲームです。

どれくらいぴったりかによって評価が変わります。

秒数は10, 20, 30, 60秒から選択できます。

誤差0.05秒以内になると…？！

※2025/5/1現在、AppStoreでの公開は行なっていません

## 遊び方

スタートボタンを押します。

30秒経ったと思ったらストップボタンを押します。

右下のresult→ボタンから結果を確認しましょう。

resetすると何度でも遊べます。

<img width="200px" src="https://github.com/user-attachments/assets/b12e8657-29a6-4182-b10f-b4ab62d03028">
<img width="200px" src="https://github.com/user-attachments/assets/cc69c8ec-09ed-4e9f-a8f7-f0f251591edd">
<img width="200px" src="https://github.com/user-attachments/assets/75ae5ad4-f0a0-473e-9975-c95220e693a1">


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
