
# 試験的な機能

現在開発段階の機能です。

- [Remap(\>QMK 0.19), Vial 対応](#remapqmk-019-vial-対応)
  - [BLE Miro Proを更新して設定ファイルを書き込む手順](#ble-miro-proを更新して設定ファイルを書き込む手順)
    - [BLE Micro Pro Web ConfiguratorでVial対応のファームウェアを書き込む](#ble-micro-pro-web-configuratorでvial対応のファームウェアを書き込む)
    - [bmp-vial対応の設定ファイルを用意する](#bmp-vial対応の設定ファイルを用意する)
    - [BLE Micro Proに設定ファイルを書き込む](#ble-micro-proに設定ファイルを書き込む)
  - [Remap, Vialでの設定変更方法](#remap-vialでの設定変更方法)
  - [BLE Miro Pro Web Configuratorに登録するための手順](#ble-miro-pro-web-configuratorに登録するための手順)
    - [デフォルトキーマップ用binファイルを用意する](#デフォルトキーマップ用binファイルを用意する)
    - [2種類のjsonファイルとデフォルトキーマップ用binファイルを登録する](#2種類のjsonファイルとデフォルトキーマップ用binファイルを登録する)


## Remap(>QMK 0.19), Vial 対応

QMK 0.19以降の破壊的な変更に合わせて[Remap](https://remap-keys.app/)の仕様も大幅に変更されています。
BLE Micro Proもこの変更に対応するため、ファームウェアの更新をおこなっています。

この更新ではRemap(VIA)だけでなく[Vial](https://get.vial.today/)にも対応できるように設定ファイルの形式を変更します。そのため、従来使用していたCONFIG.JSNやKEYMAP.JSNの代わりとなる設定ファイルを用意していただく必要があります。
Vialはブラウザ上だけでなくローカル環境での実行ファイルも用意されています。また、キーレイアウトなどの情報をキーボード側に保持しており、ファームウェアのバージョンに応じてキーコード定義を切り替えるようになっています。今後に各種ファームウェアやツールの仕様変更があったとしても、ユーザーにキーボードファームウェアの更新を強制させないことが今回の変更の目的です。

### BLE Miro Proを更新して設定ファイルを書き込む手順

Vial対応のファームウェア(bmp-vial)の手順は以下の3ステップです。

1. [BLE Micro Pro Web Configurator](https://sekigon-gonnoc.github.io/BLE-Micro-Pro-WebConfigurator/#/home)でVial対応のファームウェア(`ble_micro_pro_bootloader_1_x_x` と `ble_micro_pro_vial_1_x_x`)を書き込む
1. bmp-vial対応の設定ファイルを用意する
1. BLE Micro Proに設定ファイルを書き込む 

#### BLE Micro Pro Web ConfiguratorでVial対応のファームウェアを書き込む

従来のファームウェアと同様にWebブラウザからファームウェアを更新できます。
bmp-vialではファームウェアのメジャーバージョンが1となっています。
そのため、ブートローダは `ble_micro_pro_bootloader_1_x_x` の系を、アプリケーションは `ble_micro_pro_vial_1_x_x` 系を書き込んでください。現時点ではMass Storage機能が有効なファームウェアしかないので、`Disable Mass Storage Class`のチェックボックスは必ず外してください。

現時点では設定ファイルをWebブラウザから書き込めないためEdit Configのページはスキップしてください。

#### bmp-vial対応の設定ファイルを用意する

従来の設定ファイルが用意されていたキーボードのうち、QMK公式にinfo.jsonが存在しているか、こちらでinfo.jsonの所在を把握していたキーボードについては[Release]()ページに設定ファイルを用意しています。

それ以外のキーボードや修正が必要な場合は下記の手順に沿って設定ファイルを用意してください。
設定ファイルは下記の3種類必要です。

* vial用jsonファイル(vial.json)
  * vial用の設定ファイルです
* config用jsonファイル(config.json)
  * BLE Micro Pro用の設定ファイルです。従来とは一部の項目が変わっています
* 書き込み用binファイル(config.bin)
  * vial.jsonとconfig.jsonから生成された書き込み用のバイナリファイルです

設定ファイルは[bmp-vial-config-generator](https://sekigon-gonnoc.github.io/bmp-vial-config-generator/)を利用して生成できます。

1. 左側のテキストボックスにQMKのinfo.jsonを記入する
   1. QMK公式のリポジトリにinfo.jsonが存在する場合はテキストボックス下部にあるリストから選択できます。
2. 左下の`Generate`ボタンをクリックしてvial.jsonとconfig.binを生成する
   1. 自動生成されたvial.jsonでは内容が不十分な場合はテキストボックスの中身を書き換えてください
3. 中央下の`Append BMP custom keycodes`ボタンをクリックして、BLE Micro Pro用のカスタムキーコードリストをvial.jsonに追加する
4. `Download vial.json`ボタンをクリックしてvial.jsonをダウンロードする
5. 分割キーボードの場合は右下のリストからconfig.jsonの対象(master, slave, lpme)を選択する
6. `Download config.json`ボタンをクリックしてconfig.jsonをダウンロードする
7. `Downliad config.bin`ボタンをクリックしてconfig.binをダウンロードする

#### BLE Micro Proに設定ファイルを書き込む 

1. BLE Micro Proのアプリケーションが起動していることを確認する
   1. マスストレージとして認識されているBLE Miro Proを開き、中にCONFIG.BINがあることを確認する
2. 用意したconfig.binをドラッグアンドドロップして書き込む（ファイル名は任意）
3. 書き込み完了後に電源を再投入して、デバイス名が書き込んだキーボードに変わっていることを確認する

### Remap, Vialでの設定変更方法

* Remapは従来通りの方法で利用できます
* Vialを利用する場合、ローカル版のVialでは電源投入後の初回の接続には必ず失敗してしまいます。エラーが表示されたらRefreshボタンを押して再読み込みしてください。ブラウザ版では自動でリトライされるため、再読み込みの操作は必要ありません
* 一度Vialと接続した場合、リセットするまでRemapには接続できなくなります。Remapに再接続したい場合は、リセットするか電源を再投入してください
* Remapのマクロ定義とVialのマクロ定義が異なるため、一方で編集したマクロはもう一方で正しく表示されない場合があります。どちらで定義してもマクロの実行は可能です


### BLE Miro Pro Web Configuratorに登録するための手順

Vial対応の設定ファイルをBLE Micro Pro Web Configuratorに登録したい方は追加で以下の手順の実施をお願いします。該当キーボードの作者以外の方でもプルリクエストを作成していただいて構いません。

1. デフォルトキーマップ用binファイルを用意する
2. 2種類のjsonファイルとデフォルトキーマップ用binファイルを登録する

#### デフォルトキーマップ用binファイルを用意する

EEPROMリセット時に反映されるデフォルトキーマップを各キーボードに合わせるための設定ファイルを用意してください。

1. RemapまたはVialを使ってデフォルトにしたいキーマップをキーボードに書き込む
2. BLE Micro Proのマスストレージを開きEEPROM.BINをPCにコピーする
3. コピーしたEEPROM.BINの名前を変更する
   1. 名前はキーボード設定用のconfig.binに合わせて`<キーボード名>_default.bin`としてください
4. ファイルをBLE Micro Proに書き戻し、EEPROMをリセットしたときに意図通りのキーマップになっていることを確認する

#### 2種類のjsonファイルとデフォルトキーマップ用binファイルを登録する

BLE Miro Proのリポジトリの `bmp-vial-config/` にファイルを追加してプルリクエストを作成してください。