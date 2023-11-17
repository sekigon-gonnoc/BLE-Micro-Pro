# 新しいキーボード用の設定を作成する

## QMK用の設定から変換する

Pro Micro用のQMKがすでにある場合はその設定を利用してBLE Micro Pro向けの`config.json`を生成できます。
ベースとなるQMKのバージョンに応じて下記のいずれかの方法を使用してください

### QMK公式にマージざれている場合

https://sekigon-gonnoc.github.io/ble-micro-pro-config-generator/

でkeyboardとlayoutを選択してconvertボタンをクリックすると設定が生成されます。

### info.jsonに各種設定を用意している場合

https://sekigon-gonnoc.github.io/ble-micro-pro-config-generator/

のテキストボックスにinfo.jsonの中身を貼り付けて、検出されたlayoutを選択してconvertボタンをクリックすると設定が生成されます。

### config.hに各種設定を用意している場合

[変換スクリプト](https://github.com/sekigon-gonnoc/BLE-Micro-Pro/blob/master/AboutDefaultFirmware/keyboards/config_converter.py)を用いて`config.json`を生成できます。

```
./keyboards/config_converter.py ~/qmk_firmware/helix/rev2
```

LAYOUTマクロなどが複数定義されている場合は検出されたレイアウトの一覧が表示されるので、使いたい定義を選択してください。

## config.jsonの説明

- 設定例についてはリポジトリを参照してください

|キー|値|内容|
|---|---|---|
|version|2|config構造体のバージョン。 ブートローダ内の構造体の定義が変わらない限り変えない|
|pid, vid|string|16進数のPIDとVID|
|name|string||
|manufacture|string||
|description|string||
|rows|int|マトリクスの列数|
|cols|int|マトリクスの行数|
|device_rows|int|分割型の場合は片手分のマトリクスの列数。 一体型の場合rowsと同じにする|
|device_cols|int|分割型の場合は片手分のマトリクスの行数。 一体型の場合colsと同じにする|
|diode_direction|0~5|マトリクスの構成をあらわす。詳細は下記|
|row_pins|int array|マトリクスの行ピン。番号はPINxxに対応|
|col_pins|int array|マトリクスの列ピン。番号はPINxxに対応|
|layout|int array|qmkのレイアウトマクロに対応するもの。詳細は後述|
|mode|SPLIT_MASTER, SPLIT_SLAVE, SINGLE|分割マスター、分割スレーブ、一体型|
|startup|int|電源が入ったタイミングでBLEのアドバタイズを実行するかどうか。 [0]は実行しない、[1]で実行する。|
|led->pin|int array|LED(ws2812系)のピン。番号はPINxxに対応|
|led->num|int|LEDの数|
|keymap->locale|"US" or "JP"|USキーボードとして接続するか、JPキーボードとして接続するかの設定。keymap.jsonの変換・表示の挙動に影響|
|reserved|uint8_t[8]|予約領域。現時点では[0]はKugel用の設定、[1]はインジケータLEDのピン設定、[2]はオートスリープの時間設定に使用|

### 通信間隔の設定

無線接続時に遅延を感じる場合はperipheral, centralの max_interval, min_intervalを小さくしてください。最小値は10msで、5ms刻みで変更できます  
また、OSのBLEに関する省電力設定も確認してみてください

### マトリクスの構成

- diode_direction
 
|数値|構成
|---|---
|0|COL2ROW
|1|ROW2COL
|2|COL2ROW with LPME
|3|ROW2COL with LPME
|4|COL2ROW2COL
|5|ROW2COL2ROW

- row_pins, col_pins
  -  COL2ROW, ROW2COLの場合: 通常のマトリクスの設定。device_rows/colsに指定したのと同じ数だけピンを設定する
  -  with LPMEの場合: LPMEを使ったマトリクスの設定。BLE Micro Proが制御するマトリクスのピン設定に続けて、LPMEが制御するマトリクスのピン設定を書く。合計でrows/colsに設定したのと同じ数だけピンを設定する
  -  duplex matrixの場合: 通常のマトリクスと同じ設定を書く。

### layoutの設定

layout配列の数値はキーマトリクスの行->列の順に1から降った番号に対応し、対応する位置にあるキーマップとスイッチの対応を表しています。分割型の場合は左のマトリクスから順に数値を割当てます。

ただし、0は列の区切りを表します。

例えば次のようにマトリクスが配置された左右分割キーボードがあったとき

```
+------+-----+                +-----+-----+
 (1,0) |(1,1)|                |(1,1)|(1,0)|
+------+-----+-----+    +-----+-----+-----+
 (0,0) |(0,1)|(0,2)|    |(0,2)|(0,1)|(0,0)|
+------+-----+-----+    +-----+-----+-----+
```

左手の(0,0)が1, そのまま2,3,4,5と続いて6は存在せず、右手の(0,0)から7,8,9...と割り当てられます。これらの割当をそのまま物理的な配置順に並べ、行の区切りに0を付けます。

```
"layout":[
    4, 5,        11,10, 0,
    1, 2, 3,   9, 8, 7
]
```

<img src="https://raw.githubusercontent.com/sekigon-gonnoc/BLE-Micro-Pro/master/pin%20assign.jpg" width=300px/>


### オートスリープ

電池駆動時に一定時間無入力の状態が続くと自動的にスリープします。

スリープまでの時間は`config.reserve[2]*10min`です。

オートスリープを無効にするには`reserve[2]`に0を指定してください。
