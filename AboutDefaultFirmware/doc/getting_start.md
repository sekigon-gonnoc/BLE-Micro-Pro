# Getting start
- [Getting start](#getting-start)
  - [ブートローダ・アプリケーションのアップデート](#ブートローダアプリケーションのアップデート)
    - [ブートローダの起動](#ブートローダの起動)
    - [uf2を使ったアップデート](#uf2を使ったアップデート)
    - [nrfutilを使ったアップデート](#nrfutilを使ったアップデート)
      - [nrfutilの準備](#nrfutilの準備)
      - [アップデートの実行](#アップデートの実行)
  - [config.jsonの書き込み](#configjsonの書き込み)
  - [keymap.jsonの設定](#keymapjsonの設定)
  - [tapping_term.jsonの設定](#tapping_termjsonの設定)
  - [config.jsonの設定 (一般ユーザ向け)](#configjsonの設定-一般ユーザ向け)
    - [開発者向け情報](#開発者向け情報)
  - [設定ファイルのアップデート](#設定ファイルのアップデート)
  - [設定ファイルの削除](#設定ファイルの削除)

## ブートローダ・アプリケーションのアップデート
BLE Micro Proはブートローダとアプリケーションファームウェアがセットになって動作します

- アップデートする場合ブートローダとアプリケーションのメジャーバージョン・マイナバージョンを一致させてください。バージョン番号の表記は下記のとおりです。
  ```
    version number: <major>.<minor>.<revision>
  ```

- アップデートはブートローダ -> アプリケーションの順に行ってください。また、アプリケーションをアップデートする前にKEYMAP.JSNなどの設定ファイルのバックアップを取ってください

- [ブートローダ](https://github.com/sekigon-gonnoc/BLE-Micro-Pro/releases)と[コンパイル済みアプリケーション](https://github.com/sekigon-gonnoc/qmk_firmware/releases)はReleaseページから入手できます。  
  - コンパイル済みアプリケーションにはQMKのビルドオプションとしてTAPPING_TERM_PER_KEY, PERMISSIVE_HOLD などが設定してあります。  
  - 最新版のファームウェアを使いたい場合、自分の好きなオプションを設定したい場合やカスタムキーコードを設定したい場合は[自分でビルドする](build_bmp_qmk_firmware.md)必要があります。  
 
### ブートローダの起動
- キーボードのリセットボタンを押しながらUSB接続するとブートローダが起動します

- 既にキーボードとして動作する場合には[CLI](cli.md)からdfuコマンドを送信することでも起動できます  

- v0.2以降のブートローダとそれ以前ではアップデート方法が異なります。バージョンに応じた手順でファームウェアとブートローダをアップデートしてください

  - [マスストレージデバイスとして認識される場合](#uf2を使ったアップデート)

  - [マスストレージデバイスとして認識されないが、シリアルポートとしては認識される場合](#nrfutilを使ったアップデート)
    - どのポートがBLE Micro Proかわからない場合は、起動前後のシリアルポート一覧を比較してください

### uf2を使ったアップデート
拡張子が`.uf2`のファイルを使って書き込みます

- BLE Micro Proがマスストレージデバイスとして認識され、中に`INFO_UF2.TXT`があることを確認してください。このファイルがない場合、ブートローダの起動に失敗しているので再起動してください

- アップデートしたいuf2ファイルをコピーするとアップデートが始まります。アップデート中はケーブルを外さないでください

- アップデートが完了すると自動でアンマウントされます

- ブートローダをアップデートした場合、`INFO_UF2.TXT`を開いてアップデート完了を確認してください

- アプリケーションのアップデートの場合は`VERSION.TXT`を開いてアップデート完了を確認してください

ブートローダ、アプリケーションのアップデートが完了したら次の手順は[config.jsonの書き込み](#configjsonの書き込み)です

### nrfutilを使ったアップデート
拡張子が`.zip`のファイルを使って書き込みます

#### nrfutilの準備
書き込みソフトである[nrfutil](https://github.com/NordicSemiconductor/pc-nrfutil)を用意します。

- Windowsの場合  
    nrfutil.exeを[ダウンロード](https://github.com/NordicSemiconductor/pc-nrfutil/releases)してください

- Linux, Macの場合  
    pipでnrfutilをインストールしてください。以前はpython2.x向けでしたが現在はpython3系で動作するようです。
    ```
      pip install --user nrfutil
    ```

#### アップデートの実行
- キーボードのリセットボタンを押しながらUSB接続、またはターミナルソフトからdfuコマンドを送信してから以下を実行します。パッケージ名、ポート名は状況に応じて書き換えてください  
    ```
   nrfutil dfu usb-serial -pkg <パッケージ名>.zip -p <ポート名>
    ```
 
## config.jsonの書き込み
 - BLE Micro ProをPC等にUSBで接続するとマスストレージデバイスとして認識されます  
   アプリケーションが起動している場合は`KEYMAP.JSN`や`CONFIG.JSN`といったファイルが確認できます

 - 使いたいキーボードのconfig.jsonをコピーしてください。[keyboards](../keyboards)フォルダに使いたいキーボードがない場合は[スクリプトを使ってQMKから生成](define_new_keyboard.md)できます

 - コピー完了後、BLE Micro Proを再起動してください

## keymap.jsonの設定
 - [QMK Configurator](https://config.qmk.fm)で生成したkeymap.jsonをそのまま読み込むことができます。

 - keymap.json, tapping_term.jsonは即時反映されるので再起動は必要ありません

 - 認識できる KC_XX はQMK Configurator準拠です  
    `"KC_EXLM", "KC_AT", "KC_HASH"`

 - 書き込み時にはKC_を付けなくても認識されます。読み出し時には自動でKC_が付きます  
    `"KC_A", "A", "a"` 

 - !, @, # などの記号をそのまま書き込むこともできます。`\`, `"` を設定するときはエスケープしてください。  
    `"!", "@", "#", "\\", "\""`

 - USキーボードとJPキーボードでキーコードが違う記号を書き込んだ場合にどちらで解釈されるかはconfig.jsonの設定によります。（例: "@"： USのとき-> KC_AT, JPのとき -> JP_AT) 

 - カスタムキーコードとして[BLE Micro Pro固有のキーコード](bmp_custom_keycode.md)にも対応しています 

 - 自分でファームウェアをビルドしてカスタムキーコードを設定した場合でも辞書を定義しておけば認識できます。ANY(1255)などして数値で直接指定する方法もあります。
 
## tapping_term.jsonの設定
 - get_tapping_term()で返すキーコードとタッピングタームのペアを設定します
 - デフォルトのタッピングタームはKC_NOに設定します
 - KC_NOは一番最後に設定してください
  ```
  {"tapping_term":{
        "LT(1,KC_A)":300,  
        "KC_NO":200,
        }}
  ```

## config.jsonの設定 (一般ユーザ向け)
|キー|値|内容|
|---|---|---|
|debounce|1 ~|debounceの設定。1増やすと17ms伸びる|
|is_left_hand|0 or 1|左手用のとき1|
|mode|SPLIT_MASTER, SPLIT_SLAVE, SINGLE|分割マスター、分割スレーブ、一体型|
|startup|0 or 1|起動時に自動でアドバタイズを開始する場合は1|
|locale|US or JP|英語キーボード or 日本語キーボード|
|use_ascii|0 or 1| 1の場合keymap.jsonの表示内容がQMK準拠ではなく記号になる.<br> 例) KC_EXLM -> KC_!|
|peripheral||マスター、一体型の場合: PC等との接続に使われる設定<br>スレーブの場合: マスターとの接続に使われる設定|
|cetral||マスターの場合のみ: スレーブとの接続に使われる設定|

無線接続時に遅延を感じる場合は peripheral, central の max_interval, min_interval を小さくしてください  
また、OSのBLEに関する省電力設定も確認してみてください

### [開発者向け情報](define_new_keyboard.md)


## 設定ファイルのアップデート
  BLE Micro Pro上のファイルを直接編集することもできますが、バックアップの意味も兼ねて一度PC上にコピーしてから編集、転送することを推奨します。
  
## 設定ファイルの削除
  PCから見えているファイルを削除してもBLE Micro Proを再起動すると復活します。完全に削除してデフォルトに戻したい場合は[CLI](cli.md)からremoveコマンドを使ってください。
