# CLI

BLE Micro Proに各種のコマンドを命令したり、デバッグメッセージを確認したりできます。

BLE Micro ProのCLIを開くにはTeraTerm・screen・cuなどからシリアルポートを開いてください。

| command | description                                 |
| ------- | ------------------------------------------- |
| reset   | Reset system                                |
| adv     | Start advertising                           |
| dfu     | Jump to bootloader                          |
| show    | Show bonded devices                         |
| del     | Delete bond information                     |
| help    | Show this message                           |

## adv `<id>`

 id番目のペアリング済みデバイスに向けてアドバタイズを開始します。分割マスター設定の場合、スレーブデバイスのスキャンも開始します。idを指定しない場合はペアリングしていないデバイスも含めすべてのデバイスに向けてアドバタイズを開始します。  
 ペアリング済みデバイス一覧はshowコマンドで確認できます

## show

BLEのペアリング状況(ID, role, MAC)を表示します。

## del `<id>`

id番のデバイスとのペアリングを削除します。別途相手デバイス側に残っているペアリング情報も削除してください  
idを指定しない場合すべてのペアリング情報を削除します
