# BLE-Micro-Pro

[![Docs Status](https://img.shields.io/badge/docs-ready-orange.svg)](https://sekigon-gonnoc.github.io/BLE-Micro-Pro)

Pro Microとの互換性を意識したBL654(nrf52840モジュール)のブレークアウトボードです。主に自作キーボードでの使用を想定して設計しています。Pro Microを使用した自作キーボードに取り付けて、USB/Bluetooth Low Energyの両方に対応させることができます。  

**質問等は [Self Made Keyboard in Japan の Discord](https://discordapp.com/invite/zXCss8T) #mon-shin🔰 (トラブルシューティング) または #ble-micro-pro（開発関係の質問）チャンネルまで。**
**質問の前に過去ログを参照してください**

## 販売リンク

[BOOTH](https://nogikes.booth.pm/items/1177319)  
[遊舎工房](https://yushakobo.jp/shop/ble-micro-pro/)

<img src="https://github.com/sekigon-gonnoc/BLE-Micro-Pro/blob/master/pin%20assign.jpg" width=300px/>

## 使用上の注意点

Pro Microとの互換性を意識して設計されていますが、以下の点にご注意ください。

- 入出力は3.3Vです。ただし、5・6番ピン(SDA・SCL)のみFETによるレベルシフト回路を実装しています。

- RAWピンの最大電圧は5Vです。

## 接続確認済みデバイス

Windows 10, Androidとの接続を確認しています。ただし、使用するbluetoothアダプタによっては接続が不安定になることがあります。

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
