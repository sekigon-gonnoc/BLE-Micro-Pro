# 新しいキーボード用の設定を作成する

## コンフィグファイルの用意
Pro Micro用のQMKがすでにある場合、[変換スクリプト](../keyboards/config_converter.py)を用いて`config.json`を生成できます。

```example
keyboards/config_converter.py ~/qmk_firmware/helix/rev2
```

LAYOUTマクロなどが複数定義されている場合、最初に変換された定義が使用されます。他の定義を使いたい場合は関係のない定義を一時的に削除あるいは`//`でコメントアウトしてください。

### config.jsonの設定 (開発者向け)
|キー|値|内容|
|---|---|---|
|version|2|config構造体のバージョン. ブートローダ内の構造体の定義が変わらない限り変えない|
|pid, vid|string|16進数のPIDとVID|
|name|string||
|manufacture|string||
|description|string||
|rows|int|マトリクスの列数|
|cols|int|マトリクスの行数|
|device_rows|int|分割型の場合、片手分のマトリクスの列数. 一体型の場合rowsと同じにする|
|device_cols|int|分割型の場合、片手分のマトリクスの行数. 一体型の場合colsと同じにする|
|diode_direction|0 or 1|ROW2COLのとき 1|
|row_pins|int array|マトリクスの行ピン。番号はPINxxに対応|
|col_pins|int array|マトリクスの列ピン。番号はPINxxに対応|
|layout|int array|qmkのレイアウトマクロに対応するもの。詳細は後述|
|mode|SPLIT_MASTER, SPLIT_SLAVE, SINGLE|分割マスター、分割スレーブ、一体型|
|led->pin|int array|LED(ws2812系)のピン。番号はPINxxに対応|
|led->num|int|LEDの数|

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

<img src="https://github.com/sekigon-gonnoc/BLE-Micro-Pro/blob/master/pin%20assign.jpg" width=300px/>

## ファームウェアを作成する
 他のキーボードでも使えそうなカスタムキーコードを追加したい場合はkeyboard/ble_micro_pro に追加することも検討してください。
 ハードウェアに依存する機能を追加する場合は以下を参考に新しいキーボードを定義してください。

### Start new project
```
$ ./util/new_keyboard.sh
Generating a new QMK keyboard directory

Keyboard Name: <your keyboard name>
Keyboard Type [avr]: nrf
Your Name [sekigon-gonnoc]: 

Copying base template files... done
Copying nrf template files... done
Renaming keyboard files... done
Replacing %YEAR% with 2019... done
Replacing %KEYBOARD% with name... done
Replacing %YOUR_NAME% with sekigon-gonnoc... done

Created a new keyboard called name.

To start working on things, cd into keyboards/name,
or open the directory in your favourite text editor.
```

### Configure your project
 Settings in config.h and keymap.c will be used as defaults, and overridden by config.json and keymap.json if given.
 If you want to restore default settings, use `remove` command from [CLI](cli.md)

### [ビルド方法](doc/build_bmp_qmk_firmware.md)
