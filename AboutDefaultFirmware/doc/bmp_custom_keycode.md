# BLE Micro Pro 固有のキーコード

## カスタムキーコード
| keycode | 内容                                 |
| ------- | ------------------------------------ |
| BLE_DIS | Disable BLE HID sending              |
| BLE_EN  | Enable BLE HID sending               |
| USB_DIS | Disable USB HID sending              |
| USB_EN  | Enable USB HID sending               |
| BLE_SEL | Enable BLE and disable USB           |
| USB_SEL | Enable USB and disable BLE           |
| ADV_ID0 | Start advertising to PeerID 0        |
| ADV_ID1 | Start advertising to PeerID 1        |
| ADV_ID2 | Start advertising to PeerID 2        |
| ADV_ID3 | Start advertising to PeerID 3        |
| ADV_ID4 | Start advertising to PeerID 4        |
| ADV_ID5 | Start advertising to PeerID 5        |
| ADV_ID6 | Start advertising to PeerID 6        |
| ADV_ID7 | Start advertising to PeerID 7        |
| AD_WO_L | Start advertising without whitelist  |
| DEL_ID0 | Delete bonding of PeerID 0           |
| DEL_ID1 | Delete bonding of PeerID 1           |
| DEL_ID2 | Delete bonding of PeerID 2           |
| DEL_ID3 | Delete bonding of PeerID 3           |
| DEL_ID4 | Delete bonding of PeerID 4           |
| DEL_ID5 | Delete bonding of PeerID 5           |
| DEL_ID6 | Delete bonding of PeerID 6           |
| DEL_ID7 | Delete bonding of PeerID 7           |
| DELBNDS | Delete all bonding                   |
| ENT_DFU | Start bootloader                     |
| ENT_WEB | Start web configurator               |
| ENT_SLP | Deep sleep mode                      |
| BATT_LV | Display battery level in milli volts |
| SAVE_EE | Save eeprom config                   |
| DEL_EE  | Delete eeprom config                 |
| xEISU   | Send `LANG1` or `` Alt + ` ``        |
| xKANA   | Send `LANG2` or `` Alt + ` ``        |

## 拡張キーコード

 - LTやTDを使いやすくした独自の構文
 - `EX()`で囲い明示的に宣言する
 - 全ての関数でKCに16ビットコードが使えるので、モディファイアと組み合わせたキーやカスタムキーコードを指定できる
 - KEYMAP.JSNの中に32種類まで登録可能。これを超えた場合は無視される。

| 構文                            | 内容                                                 |
| ------------------------------- | ---------------------------------------------------- |
| LTE(layer, kc)                  | LTと同じ。`EX(LTE(1, xEISU))`                        |
| TLT(layer1, layer2, layer3, kc) | LTとtri_layer_updateを組み合わせたもの               |
| TDD(kc1, kc2)                   | 一回タップするとkc1, 二回タップするとkc2が入力される |
| TDH(kc1, kc2)                   | タップするとkc1, ホールドするとkc2が入力される       |