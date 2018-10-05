# BLE-Micro-Pro
Pro Microとの互換性を意識したBL654(nrf52840モジュール)のブレークアウトボードです。主に自作キーボードでの使用を想定して設計しています。Pro Microを使用した自作キーボードに取り付けて、USB/Bluetooth Low Energyの両方に対応させることができます。

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

ブートローダー書き込み済みの場合、BOOTピンをGNDに落としながら起動、あるいはファームウェアから呼び出すことでUSB経由でのファームウェアの書き込みができます。

ブートローダーを使わない場合は裏面に露出したパッドからSWDでファームウェアを書き込みます。

## 使い方(自作キーボード編)

nrf52対応のqmk_firmwareは[こちら](https://github.com/sekigon-gonnoc/qmk_firmware/tree/nrf52)

### ビルド環境
通常のqmk用の環境に加えて、arm-none-eabi-gccが必要です。(Version 7-2017-q4-majorで動作確認)

また、[nRF5_SDK v15.0.0](https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/)をダウンロードして適当な場所に展開してください。

### ファームウェア作成
qmk_firmware/keyboard/ble_micro_testが一体型、qmk_firmware/keyboard/ergo42_bleが左右分離型のサンプルとなっています。
各キーボードのrule.mk中のNRFSDK_ROOTはnRF5_SDKの展開場所を指定してください。

    NRFSDK_ROOT := <path to SDK>

ビルドコマンドは通常通りです。

#### 一体型の場合
編集する必要があるファイルはble_micro_test/config.hとble_micro_test/pro_v1/config.hの2つです。

- MATRIX_ROWS, MATRIX_COLS: 通常通り
- THIS_DEVICE_ROWS, THIS_DEVICE_COLS: MATRIX_ROWS, MATRIX_COLSと同じ値に設定
- MATRIX_ROW_PINS, MATRIX_COL_PINS: キーマトリクスに使用しているピン番号を指定
- IS_LEFT_HAND: 必ずtrue

#### 分割型の場合
マスタとスレーブで異なるファームウェアが必要です。現状ではマスタのみUSB接続に対応しています。編集するファイルはergo42_ble/config.hとergo42_ble/master/config.hとergo42_ble/slave/config.hの3つです。

- MATRIX_ROWS, MATRIX_COLS: 通常通り
- THIS_DEVICE_ROWS, THIS_DEVICE_COLS: マスタ、スレーブそれぞれの列数と行数。8x16まで対応。
- MATRIX_ROW_PINS, MATRIX_COL_PINS: キーマトリクスに使用しているピン番号を指定
- IS_LEFT_HAND: 左手側ならtrue、右手側ならfalse

#### キーマップ
サンプルを参考にして(分割型の場合マスタ側のキーに)以下の関数を実行するカスタムコードを設定することをお勧めします。

- advertising_wo_whitelist()　新しいデバイスとペアリングするときに使います。
- restart_advertising_id(id)　指定したidのデバイスとの接続を試みます。分割型の場合id=0はスレーブとなるため、id=1から各デバイスに割り当てられます。
- set_usb_enabled(bool)　USB経由の送信を有効/無効にします。起動時は無効になっているので、matrix_init_user中で有効にするか、キーマップに割り当ててください。
- set_ble_enabled(bool)　BLE経由の送信を有効/無効にします。起動時は有効になっています。


### ファームウェア書き込み
SWDでの書き込みと、ブートローダ書き込み済みの場合はDFUでの書き込みに対応しています。
以下ではDFUでの書き込みについて説明します。

#### セットアップ
python2.7をインストールし、pipでnrfutilを入れます。
    
    pip install nrfutil

#### ファームウェアパッケージの作成
qmkで作成したファームウェアをdfu用にパッケージします。
    
    nrfutil pkg generate --debug-mode --hw-version 52 --sd-req 0xA9 --application <firmware>.bin <package>.zip

#### 書き込み
キーボードのリセットボタンを押しながら電源投入、あるいはキーマップに設定したコマンドからブートローダを起動します。キーボードではなくCOMポートとして認識されていれば番号を確認して書き込みます。
    
    nrfutil dfu usb_serial -pkg <package>.zip -p <COMport>
書き込みに成功すれば自動で再起動してUSBキーボードとして認識されます。

#### (分割型)マスタとスレーブの接続
分割型の場合は、初回起動時にマスタとスレーブの接続が確立してからパソコン等とのペアリングを実行してください。
マスタのUSB送信を有効にして、スレーブの入力が反映されることを確認してからパソコン等とのペアリングを実行するとよいでしょう。

#### パソコン等とのペアリング
advertising_wo_whitelist()を実行すると、BLE Micro Proがアドバタイズを開始します。パソコン等からスキャンすると、設定したキーボード名のデバイスが確認できるはずです。

2台目以降のパソコン等とペアリングする場合は、他のペアリング済みパソコン等のBluetoothを無効化してからadvertising_wo_whitelist()を実行してください。

指定したペアリング済みパソコン等に接続したい場合、restart_advertising_id(id)を実行します。idはペアリング順です。分割型の場合、id=0はスレーブとなっていることを前提としています。
