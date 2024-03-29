# 特徴/機能一覧

## USB/BLEでの接続
- BLE Micro Proを1台使用した一体型キーボードの完全無線化
  - Naked60BMPのような一体型キーボードの場合、Pro MicroをBLE Micro Proに置き換えることで無線化できます
  - 消費電力はマスター側で\~100uAで、300mAhの電池を使うと3000時間もつ計算です

- BLE Micro Proを2台使用した分割キーボードの完全無線化
  - HelixやErgo42のような分割型の自作キーボードを完全無線化できます
  - 消費電力はマスター側で\~300uA、スレーブ側で\~100uA程度で、300mAhの電池を使うと1000時間もつ計算です

- BLE Micro ProとLPME-IOを使用した部分無線化
  - 分割キーボードの片方にBLE Micro Proを、もう一方にLPME-IOを搭載することで左右の通信は有線、デバイスとの通信は無線という構成が実現できます
    - LPME-IOを使用するにはキーボード基板がI2Cによる左右の通信に対応している必要があります 


## プログラミングレスでのファームウェア更新・設定変更・キーマップ書き換え
  - BLE Micro Proをパソコンに接続するとUSBドライブとして認識され、設定ファイルを書き込むことでキーボードの設定やキーマップを書きかえることができます。そのため、取り付けるキーボードを変えたりキーマップを変えたりするときにプログラミングしなおす必要がありません。
  - キーマップはRemap, Vialを使って変更できます。Vialを使うことでTapping Termなどの設定を変更したり、コンボ・タップダンス・オーバーライドを設定することもできます
  - ブートローダー起動時もUSBドライブとして認識され、ファームウェアをドラッグアンドドロップすることでアップデートできます
  - セキュリティの都合等でUSBドライブとして認識されると困る場合には機能を無効化できます

## その他

- 穴径がコンスルーに対応しているため、コンスルーを使う場合はハンダ付け不要
- BLEの接続状況を示すためのインジケータLED（ディスクリートのLEDによる）
- 無線接続中、一定時間の間に入力がないと自動的に省電力モードに移行（無効化可）

## QMKの機能対応状況
|機能|対応|補足|
|--|--|--|
|キーボード|✔|
|マウス|✔|
|System/Consumer(音量など)|✔|
|エンコーダ|✔|
|VIA(Remap)|✔||
|VIAL|✔||
|Console|✔|HIDではなくシリアルポートによる実装。print/dprintに加えて[CLI](cli.md)を提供|
|Raw|✔|
|LED|✔|USB電源駆動時のみ。左右同期も実装済み|
|OLED|✔|
|eeprom|✔||
|SPI|✔|
|I2C|✔|
|Analog|✔|17,18,20番ピンのみ|
|Audio|❌|
|NKRO|❌|
|PS/2|❌|
|USART|❌|

## ハードウェア仕様

### 電源
以下の二系統から供給可能。RAW, VCCからの供給がBATより優先される
  - BAT (1.7V--3.6V)
  - RAW or VCC (3V--5V)
    - ただし、RAW, VCC >= BATのときのみ

### 入出力
  - 電源電圧か3.3Vの低い方 (**5Vトレラントではありません**)
  - 5・6番ピン(Pro MicroのSDA・SCL)のみFETによるレベルシフト回路を実装

### 接続確認済みデバイス

- Windows, Androidとの接続を確認しています。ただし、使用するbluetoothアダプタによっては接続が不安定になることがあります。
