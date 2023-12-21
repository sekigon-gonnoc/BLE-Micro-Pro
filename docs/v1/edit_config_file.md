# 新しいキーボード用の設定を作成する

## config.jsonの説明

|キー|値|内容|
|---|---|---|
|version|3|config構造体のバージョン。 ブートローダ内の構造体の定義が変わらない限り変えない|
|pid, vid|string|16進数のPIDとVID|
|name|string||
|manufacture|string||
|rows|int|マトリクスの列数|
|cols|int|マトリクスの行数|
|device_rows|int|分割型の場合は片手分のマトリクスの列数。 一体型の場合rowsと同じにする|
|device_cols|int|分割型の場合は片手分のマトリクスの行数。 一体型の場合colsと同じにする|
|diode_direction|0~5|マトリクスの構成をあらわす。詳細は下記|
|row_pins|int array|マトリクスの行ピン。番号はPINxxに対応|
|col_pins|int array|マトリクスの列ピン。番号はPINxxに対応|
|mode|SPLIT_MASTER, SPLIT_SLAVE, SINGLE|分割マスター、分割スレーブ、一体型|
|startup|int|電源が入ったタイミングでBLEのアドバタイズを実行するかどうか。 [0]は実行しない、[1]で実行する。|
|led->pin|int array|LED(ws2812系)のピン。番号はPINxxに対応|
|led->num|int|LEDの数|
|reserved|uint8_t[8]|予約領域。現時点では[1]はインジケータLEDのピン設定、[2]はオートスリープの時間設定に使用|

### 通信間隔の設定

無線接続時に遅延を感じる場合はperipheral, centralの max_interval, min_intervalを小さくしてください。最小値は10msで、5ms刻みで変更できます  
また、OSのBLEに関する省電力設定も確認してみてください

### マトリクスの構成

#### diode_direction
 
|数値|構成|説明
|---|---|---|
|0|COL2ROW|QMKと同じ|
|1|ROW2COL|QMKと同じ|
|2|COL2ROW with LPME|master側がCOL2ROWでスレーブ側にはLPMEを搭載|
|3|ROW2COL with LPME|master側がROW2COLでスレーブ側にはLPMEを搭載|
|4|COL2ROW2COL|duplex-matrix。COL2ROWでスキャンしたあとROW2COLでスキャンする。modeがSINGLEのときのみ対応|
|5|ROW2COL2ROW|duplex-matrix。ROW2COLでスキャンしたあとCOL2ROWでスキャンする。modeがSINGLEのときのみ対応|

#### row_pins, col_pins
  -  COL2ROW, ROW2COLの場合: 通常のマトリクスの設定。device_rows/colsに指定したのと同じ数だけピンを設定する
  -  with LPMEの場合: LPMEを使ったマトリクスの設定。BLE Micro Proが制御するマトリクスのピン設定に続けて、LPMEが制御するマトリクスのピン設定を書く。合計でrows/colsに設定したのと同じ数だけピンを設定する
  -  duplex matrixの場合: 最初にスキャンする方向に合わせてrow_pins, col_pinsを設定する。device_rows, device_colsにはrow_pins, col_pinsの要素数を指定する。rowsにはdevice_rowsの2倍の値を、colsにはdevice_colsと同じ値を設定する

<img src="https://raw.githubusercontent.com/sekigon-gonnoc/BLE-Micro-Pro/master/pin%20assign.jpg" width=300px/>


### オートスリープ

電池駆動時に一定時間無入力の状態が続くと自動的にスリープします。

スリープまでの時間は`config.reserve[2]*10min`です。

オートスリープを無効にするには`reserve[2]`に0を指定してください。
