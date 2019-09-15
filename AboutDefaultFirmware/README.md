# BLE Micro Pro 標準ファームウェア (beta版)

## 特徴
 キーボードやキーマップごとにファームウェアをビルドし直すのではなく、マトリクスの構造やキーマップといった情報をBLE Micro Pro上のファイルを編集して変更します

 BLE Micro Proをパソコンに繋ぐとマスストレージデバイスとして認識され、設定ファイルを編集できます

 キーマップの書き換えには[QMK Configurator](https://config.qmk.fm)が生成したjsonファイルも使用できます

 <img src="https://user-images.githubusercontent.com/43873124/64910835-cfccac80-d755-11e9-89d0-f8ec5114f2bd.png">
 
## 制約 
 defineで切り替えるタイプのQMKの設定を変更したい場合や、キーマップにカスタムキーコードなどを追加したい場合はファームウェアのビルド/書き込みが必要です

 その場合でもビルド環境の用意は以前より簡単になっています

## 使い方 
- [Getting start](doc/getting_start.md)
- [ビルド方法](doc/build_bmp_qmk_firmware.md)
- [Command Line Interface](doc/cli.md)
- [キーボード開発者向け情報](doc/define_new_keyboard.md)