# キーマップの設定

## KEYMAP.JSNの編集
- 489キー分の設定を保存できます

- [QMK Configurator](https://sekigon-gonnoc.github.io/qmk_configurator/)で生成したkeymap.jsonをそのまま読み込めます。

- keymap.json, tapping_term.jsonは即時反映されるので再起動は必要ありません。

- 認識できる KC_XX はQMK Configurator準拠です。
    `"KC_EXLM", "KC_AT", "KC_HASH"`

- 書き込み時にはKC_を付けなくても認識されます。読み出し時には自動でKC_が付きます。
    `"KC_A", "A", "a"` 

- !, @, # などの記号をそのまま書き込むこともできます。`\`, `"` を設定するときはエスケープしてください。  
    `"!", "@", "#", "\\", "\""`

- JPキーボードとして使いたい場合は、config.jsonのlocaleをJPに設定した上で、[QMK Configurator](https://sekigon-gonnoc.github.io/qmk_configurator/)のJPタブからキーコードを選択してください

- カスタムキーコードとして[BLE Micro Pro固有のキーコード](#ble-micro-pro固有のキーコード)にも対応しています。

- 自分でファームウェアをビルドしてカスタムキーコードを設定した場合でも辞書を定義しておけば認識できます。ANY(1255)などして数値で直接指定する方法もあります。

## BLE Micro Pro固有のキーコード

BLE Micro Pro用のQMKには、QMKのカスタムキーコードとして定義済みの機能と、レイヤなどの引数をとる独自の構文が用意されています。

### カスタムキーコード

| keycode | 内容                                 |
| ------- | ------------------------------------ |
| BLE_DIS | Disable BLE HID sending              |
| BLE_EN  | Enable BLE HID sending               |
| USB_DIS | Disable USB HID sending              |
| USB_EN  | Enable USB HID sending               |
| SEL_BLE | Enable BLE and disable USB           |
| SEL_USB | Enable USB and disable BLE           |
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

### 拡張キーコード

- LTやTDを使いやすくした独自の構文です。
- `EX()`で囲う必要があります。例: `EX(LTE(2, xEISU))`
- 全ての関数でKCに16ビットコードが使えるので、モディファイアと組み合わせたキーやカスタムキーコードを指定できます。
- KEYMAP.JSNの中に32種類まで登録でき、これを超えた場合は無視されます。

| 構文                            | 内容                                                 |
| ------------------------------- | ---------------------------------------------------- |
| LTE(layer, kc)                  | LTと同じ。`EX(LTE(2, xEISU))`                        |
| TLT(layer1, layer2, layer3, kc) | LTとtri_layer_updateを組み合わせたもの               |
| TDD(kc1, kc2)                   | 一回タップするとkc1, 二回タップするとkc2が入力される |
| TDH(kc1, kc2)                   | タップするとkc1, ホールドするとkc2が入力される       |
| CMB(kc1, kc2, kc3)              | コンボの設定。このキー自体を押しても何も起きない。kc1とkc2を同時押しすることでkc3が入力される。kc2には8bitコードしか指定できない       |
