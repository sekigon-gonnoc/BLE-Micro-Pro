#BLE-USB HIDブリッジドングル

(開発中)BLE Micro ProやMDBT50Q-RXを使って、BLEとUSBのHIDをブリッジします。
```
PC <--USB HID--> Dongle <--BLE HID--> Keyboard
```

- パソコンからはドングルがUSBキーボードに見えるため、OSのBLEサポートに依存せずにキーボードを無線接続できます
- BLE Micro Pro用のファームウェアを使ったキーボード意外と接続しても正しく動作しません
  - 2020/05現在、レポートディスクリプタの解釈を飛ばして固定値を使用しているため
- 旧ファームウェアのプロジェクト構造を使用しているため、[nRF SDKを用意してビルドする](deprecated/README.md)必要があります
  ```
    git checkout nrf52
    make ble_micro_pro/(dongle|mdbt50rx):(nrfutil|uf2)
  ```
- 最大5台同時に接続出来ます