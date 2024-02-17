# CLI

**このページは旧バージョンのファームウェアについての説明です。最新版ファームウェアの説明は[こちら](../v1/README.md)**

BLE Micro Proに各種のコマンドを命令したり、デバッグメッセージを確認したりできます。

BLE Micro ProのCLIを開くには、[QMK Configurator](https://sekigon-gonnoc.github.io/qmk_configurator)か、TeraTermやscreen, cuなどからシリアルポートを開いてください。

| command | description                                 |
| ------- | ------------------------------------------- |
| reset   | Reset system                                |
| adv     | Start advertising                           |
| dfu     | Jump to bootloader                          |
| show    | Show bonded devices                         |
| del     | Delete bond information                     |
| help    | Show this message                           |
| map     | Show keymap                                 |
| conf    | Show config                                 |
| conv    | Show keymap                                 |
| update  | Update file                                 |
| remove  | Remove file (0: config.json, 1:keymap.json) |
| dump    | Dump memory                                 |
| dumps   | Dump memory                                 |
| led     | LED control                                 |
| ee      | eeprom control (show, save, del)            |
| web     | Start web config mode                       |
| i2c     | Test i2c                                    |

## adv `<id>`

 id番目のペアリング済みデバイスに向けてアドバタイズを開始します。分割マスター設定の場合、スレーブデバイスのスキャンも開始します。idを指定しない場合はペアリングしていないデバイスも含めすべてのデバイスに向けてアドバタイズを開始します。  
 ペアリング済みデバイス一覧はshowコマンドで確認できます

## show

BLEのペアリング状況(ID, role, MAC)を表示します。

## del `<id>`

id番のデバイスとのペアリングを削除します。別途相手デバイス側に残っているペアリング情報も削除してください  
idを指定しない場合すべてのペアリング情報を削除します

## conv `<string>`

`<string>`をキーコードに変換します。keymap.jsonに使える文字列かどうか確認できます。

## remove `<id>`

マスストレージ上のファイルを削除しデフォルトのファイルを復元します。  
0: config.json, 1: keymap.json, 2:tapping_term.json

## led `<pattern>`

LEDを点灯します

## ee [show, save, or del]

eepromをエミュレーションします。eeprom上に今の設定を保存したい場合はsaveしてください。
