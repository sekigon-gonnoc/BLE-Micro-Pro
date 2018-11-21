# BLE-Micro-Pro
Pro Microとの互換性を意識したBL654(nrf52840モジュール)のブレークアウトボードです。主に自作キーボードでの使用を想定して設計しています。Pro Microを使用した自作キーボードに取り付けて、USB/Bluetooth Low Energyの両方に対応させることができます。

<img src="https://github.com/sekigon-gonnoc/BLE-Micro-Pro/blob/master/pin%20assign.jpg" width=300px/>

## 使用上の注意点
Pro Microとの互換性を意識して設計されていますが、以下の点にご注意ください。

- 入出力は3.3Vです。ただし、5・6番ピン(SDA・SCL)のみFETによるレベルシフト回路を実装しています。

- RAWピンの最大電圧は5Vです。

## 接続確認済みデバイス
Windows10, Android5.0.2, Raspbianとの接続を確認しています。ただし、使用するbluetoothアダプタによっては接続が不安定になることがあります。

## 使い方(ハードウェア編)

USBコネクタの横にあるBATピンから、あるいはUSBコネクタ、RAWピン、VCCピンから電源供給できます。

- BATピン (1.7V--3.6V)
- RAW, VCC (3V--5V)
    - ただし、RAW, VCC >= BAT

コンスルーに対応しているため、はんだ付けせずに基板に取り付けることも可能です。

21番ピンは5Vをダイオードで電圧降下させて4.3Vにしています。これは、WS2812などのシリアルLEDを3.3Vの信号で光らせるためです。
Helixなど24番ピンと21番ピンをショートさせているPCBの場合は、24番ピンのピンヘッダを抜き去ることでLEDが光るようになります。
LEDの電源を24番ピンからしか取っていないキーボードの場合は、はんだ付けをして21番ピンから電源を取るように改造してください。
前述のようにダイオードを挟んでいるので21・24番ピンがショートしていても壊れません。

ブートローダー書き込み済みの場合、BOOTピンをGNDに落としながら起動、あるいはファームウェアから呼び出すことでUSB経由でのファームウェアの書き込みができます。

ブートローダーを使わない場合は裏面に露出したパッドからSWDでファームウェアを書き込みます。

## 使い方(自作キーボード編)

nrf52対応のqmk_firmwareは[こちら](https://github.com/sekigon-gonnoc/qmk_firmware/tree/nrf52)

- 既にqmk_firmwareを使っている場合

        git remote add sekigon https://github.com/sekigon-gonnoc/qmk_firmware.git
        git pull sekigon nrf52
        git checkout nrf52
- 初めて使う場合

        git clone --depth 1 -b nrf52 https://github.com/sekigon-gonnoc/qmk_firmware.git

### ビルド環境
pro micro用の環境に加えて、arm-none-eabi-gccが必要です。(Version 7-2017-q4-majorで動作確認)
QMK公式のセットアップ手順の際に全てをインストールしていれば、arm用の環境も同時にインストールされているはずです。
arm用の環境を外してセットアップしていた場合は、もう一度セットアップ用のコマンドを実行すれば追加インストールできます。

また、[nRF5_SDK v15.0.0](https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/)をダウンロードして適当な場所に展開してください。

### ファームウェア作成

#### キーマップ
サンプルを参考にして(分割型の場合マスタ側のキーに)以下の関数を実行するカスタムコードを設定することをお勧めします。

|関数|説明|
|:--|:--|
|advertising_wo_whitelist()|新しいデバイスとペアリングするときに使います。
|restart_advertising_id(id)|指定したidのデバイスとの接続を試みます。分割型の場合id=0はスレーブとなるため、id=1から各デバイスに割り当てられます。
|set_usb_enabled(bool)|USB経由の送信を有効/無効にします。起動時は無効になっているので、matrix_init_user中で有効にするか、キーマップに割り当ててください。
|set_ble_enabled(bool)|BLE経由の送信を有効/無効にします。起動時は有効になっています。


### ファームウェアの書き込み
SWDでの書き込みと、ブートローダ書き込み済みの場合はDFUでの書き込みに対応しています。
以下ではDFUでの書き込みについて説明します。

#### セットアップ(Windows(MSYS2))
[nrfutil.exe](https://github.com/NordicSemiconductor/pc-nrfutil/releases)をダウンロードし、~/qmk_utilに保存します。

#### セットアップ(Mac, Linux)
pipでnrfutilを入れます。(python2.7)
    
    pip install nrfutil

#### パッケージの作成と書き込み

ビルドする前に環境変数としてnRF SDKの場所を設定してください

    export NRFSDK15_ROOT=<path to sdk> #例 /c/dev/nRF5_SDK_15.0.0_a53641a
    
初回はライブラリをビルドするため時間がかかります。分割型の場合はmaster用とslave用の両方をビルドしてください。

    make <keyboard>/<master or slave>:nrfutil
を実行することで、ビルド後にそのままファームウェアが書き込めます。
> Detecting USB port, put your controller into dfu-mode now

と表示されたら、キーボードのリセットボタンを押しながら電源投入、あるいはキーマップに設定したコマンドからブートローダを起動します。初回書き込み時は自動的にブートローダが起動します。
書き込みに成功すれば自動で再起動してUSBキーボードとして認識されます。

[書き込み時にエラーが出る](https://github.com/sekigon-gonnoc/BLE-Micro-Pro/blob/master/FAQ.md#%E6%9B%B8%E3%81%8D%E8%BE%BC%E3%81%BF%E6%99%82%E3%81%AB%E3%83%8F%E3%83%83%E3%82%B7%E3%83%A5%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%8C%E5%87%BA%E3%82%8B)

##### 書き込み時にusb_serialが見つからないとエラーが出る場合(MacOSなど？)
qmk/tmk_core/nrf.mkの862行目

    $(NRFUTIL) dfu usb_serial -pkg $(TARGET).zip -p $$USB; \
を

    $(NRFUTIL) dfu usb-serial -pkg $(TARGET).zip -p $$USB; \
に書き換えてください

#### (分割型)マスタとスレーブの接続
分割型の場合は、初回起動時にマスタとスレーブの接続が確立してからパソコン等とのペアリングを実行してください。
そのため、初回起動時はUSB接続し、TeraTermなどのターミナルソフトを使ってシリアルポートを開いて、情報を確認しながら接続するのが無難です。
マスタのUSB送信を有効にして、スレーブの入力が反映されることを確認してからパソコン等とのペアリングを実行するとよいでしょう。

#### パソコン等とのペアリング
advertising_wo_whitelist()を実行すると、BLE Micro Proがアドバタイズを開始します。パソコン等からスキャンすると、設定したキーボード名のデバイスが確認できるはずです。

2台目以降のパソコン等とペアリングする場合は、他のペアリング済みパソコン等のBluetoothを無効化してからadvertising_wo_whitelist()を実行してください。

指定したペアリング済みパソコン等に接続したい場合、restart_advertising_id(id)を実行します。idはペアリング順です。分割型の場合、id=0はスレーブとなっていることを前提としています。

### 新しいキーボード用ファームウェアの作成
qmk_firmware/keyboard/ble_micro_testが一体型、qmk_firmware/keyboard/ergo42_ble, helix_bleなどが左右分離型のサンプルとなっています。
#### 一体型の場合
編集する必要があるファイルはble_micro_test/config.hとble_micro_test/pro_v1/config.hの2つです。

|パラメータ|変更方法|
|:--|:--|
|MATRIX_ROWS, MATRIX_COLS| 通常通り|
|THIS_DEVICE_ROWS, THIS_DEVICE_COLS| MATRIX_ROWS, MATRIX_COLSと同じ値に設定|
|MATRIX_ROW_PINS, MATRIX_COL_PINS| キーマトリクスに使用しているピン番号を指定|
|IS_LEFT_HAND| 必ずtrue|

#### 分割型の場合
マスタとスレーブで異なるファームウェアが必要です。現状ではマスタのみUSB接続に対応しています。編集するファイルはergo42_ble/config.hとergo42_ble/master/config.hとergo42_ble/slave/config.hの3つです。

|パラメータ|変更方法|
|:--|:--|
|MATRIX_ROWS, MATRIX_COLS| 通常通り|
|THIS_DEVICE_ROWS, THIS_DEVICE_COLS| マスタ、スレーブそれぞれの列数と行数。8x16まで対応|
|MATRIX_ROW_PINS, MATRIX_COL_PINS| キーマトリクスに使用しているピン番号を指定|
|IS_LEFT_HAND| 左手側ならtrue、右手側ならfalse|
|BLE_NUS_MAX_INTERVAL| 左右間の通信間隔(ms)　下げると消費電力が増える|
