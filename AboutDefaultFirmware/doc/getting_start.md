# Getting start


## ブートローダのアップデート

　nRF SDK依存のコードは全てブートローダ内部に移行しました。以前のバージョンを使用している場合はアップデートしてください。

### nrfutilの準備
事前に[nrfutil](https://github.com/NordicSemiconductor/pc-nrfutil)を用意してください。

- Windowsの場合  
    nrfutil.exeを[ダウンロード](https://github.com/NordicSemiconductor/pc-nrfutil/releases)する

- Linux, Macの場合  
    pip2でnrfutilをインストールする
    ```
      pip2 install --user nrfutil
    ```

### アップデート方法
- キーボードのリセットボタンを押しながらUSB接続、またはターミナルソフトからdfuコマンドを送信してから以下を実行  
    ```
   nrfutil dfu usb-serial -pkg ble_micro_pro_bootloader.zip -p <ポート名>
    ```
 
## ファームウェアのアップデート

 標準ファームウェアとして[コンパイル済みのファームウェア](https://github.com/sekigon-gonnoc/qmk_firmware/releases/tag/bmp-0.0.1)を定期的にリリースします。
 ビルドオプションとしてTAPPINT_TERM_PER_KEY, PERMISSIVE_HOLD などが設定してあります。
 最新版のファームウェアを使いたい場合、自分の好きなオプションを設定したい場合やカスタムキーコードを設定したい場合は[自分でビルドする](build_bmp_qmk_firmware.md)必要があります。  
   ```
   nrfutil dfu usb-serial -pkg <firmware>.zip -p <ポート名>
   ```
 
## 設定ファイルの書き込み
 - BLE Micro Pro をPC等にUSBで接続するとマスストレージデバイスとして認識されます
 - 使いたいキーボードのconfig.jsonとkeymap.jsonをコピーしてから電源を再投入してください
 - keymap.json, tapping_term.jsonは即時反映されるので再起動は必要ありません。

### keymap.jsonの設定
 - [QMK Configurator](https://config.qmk.fm)で生成したkeymap.jsonをそのまま読み込むことができます。
 - 認識できる KC_XX はQMK Configurator準拠です  
    `"KC_EXLM", "KC_AT", "KC_HASH"`
 - 書き込み時にはKC_を付けなくても認識されます。読み出し時には自動でKC_が付きます  
    `"KC_A", "A", "a"` 
 - !, @, # などの記号をそのまま書き込むこともできます。`\`, `"` を設定するときはエスケープしてください。  
    `"!", "@", "#", "\\", "\""`
 - USキーボードとJPキーボードでキーコードが違う記号を書き込んだ場合にどちらで解釈されるかはconfig.jsonの設定によります。（例: ：JPのとき "@" -> JP_A) 
 - カスタムキーコードとして[BLE Micro Pro固有のキーコード](bmp_custom_keycode.md)にも対応しています 
 - 自分でファームウェアをビルドしてカスタムキーコードを設定した場合でも辞書を定義しておけば認識できます。ANY(1255)などして数値で直接指定する方法もあります。
 
### tapping_term.jsonの設定
 - get_tapping_term()で返すキーコードとタッピングタームのペアを設定します
 - デフォルトのタッピングタームはKC_NOに設定します
  ```
  {"tapping_term":{
        "LT(1,KC_A)":300,  
        "KC_NO":200,
        }}
  ```

### config.jsonの設定 (一般ユーザ向け)
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

### [開発者向け情報](define_new_keyboard.md)


## 設定ファイルのアップデート
  BLE Micro Pro上のファイルを直接編集することもできますが、バックアップの意味も兼ねて一度PC上にコピーしてから編集、転送することを推奨します。
  
## 設定ファイルの削除
  PCから見えているファイルを削除してもBLE Micro Proを再起動すると復活します。完全に削除してデフォルトに戻したい場合は[CLI](cli.md)からremoveコマンドを使ってください。
