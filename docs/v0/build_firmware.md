# ファームウェアをビルドする

- [環境構築](#環境構築)
  - [ファームウェアのリポジトリをクローンする](#ファームウェアのリポジトリをクローンする)
  - [必要なツールをインストールする](#必要なツールをインストールする)
- [ビルドする](#ビルドする)
  - [uf2ファイルを生成する](#uf2ファイルを生成する)
- [生成したファームウェアを書き込む](#生成したファームウェアを書き込む)
  - [nrfutilで書き込む](#nrfutilで書き込む)
- [新しいキーボードのフォルダをつくる](#新しいキーボードのフォルダをつくる)
- [カスタムキーコードを追加する](#カスタムキーコードを追加する)

## 環境構築

導入手順はQMKとほとんど同様です。基本的にはQMKの導入手順にしたがって必要ソフトをインストールしてください。


### ファームウェアのリポジトリをクローンする

- QMK公式のqmk_firmwareリポジトリとは別にBLE Micro Pro用のリポジトリをクローンする必要があります。
- ここでは `qmk_firmware_bmp` という名前でクローンします。

``` 
git clone --depth 1 -b dev/ble_micro_pro https://github.com/sekigon-gonnoc/qmk_firmware.git qmk_firmware_bmp
```

### 必要なツールをインストールする

以下のコマンドを実行してビルドに必要なツールをインストールします。

```
cd qmk_firmware_bmp
./util/qmk_install.sh
```

QMK公式とは異なりsubmoduleのlufaやChibiOSには依存していないため、`make git-submodules`は実行する必要がありません。

uf2ではなくnrfutilを使って書き込む場合、追加でnrfutilもインストールします。
```
pip install nrfutil --user
```

## ビルドする

### uf2ファイルを生成する

以下のコマンドでuf2ファイルが生成されます。

```
make ble_micro_pro:default:uf2
```

後述の方法で新しく定義したキーボードをビルドする場合は以下の形式になります。

```
make <keyboard>:<keymap>:uf2
```

## 生成したファームウェアを書き込む

ブートローダを起動してください。ブートローダの起動は以下のいずれかにより行えます。

- リセットボタンを押しながらUSBケーブルで接続する
- [CLI](cli.md)からdfuコマンドを発行する
- リセットボタンを長押しする（ver0.4から）

ブートローダを起動すると外部メディアとして認識されます。外部メディアは `BLEMICROPRO` という名前です。
この外部メディアに生成されたuf2ファイルをコピーすることでファームウェアがアップデートされます。

### (参考)nrfutilで書き込む場合

uf2ファイルを生成する代わりに以下のコマンドを実行します。

```
make ble_micro_pro:<keymap>:nrfutil
```

出力を読んでnrfutil用のzipファイルが生成され書き込み待機状態になったことを確認したら、BLE Micro Proのブートローダを起動します。
ブートローダを起動する方法は以下のいずれかです。

- リセットボタンを押しながらUSBケーブルで接続する
- [CLI](cli.md)からdfuコマンドを発行する
- リセットボタンを長押しする（ver0.4から）


## 新しいキーボードのフォルダをつくる

既存のフォルダ(`ble_micro_pro`など)をコピーするか、以下のスクリプトを使って用意してください。

```
$ ./util/new_keyboard.sh
Generating a new QMK keyboard directory

Keyboard Name: <your keyboard name>
Keyboard Type [avr]: nrf
Your Name [sekigon-gonnoc]: 

Copying base template files... done
Copying nrf template files... done
Renaming keyboard files... done
Replacing %YEAR% with 2019... done
Replacing %KEYBOARD% with name... done
Replacing %YOUR_NAME% with sekigon-gonnoc... done

Created a new keyboard called name.

To start working on things, cd into keyboards/name,
or open the directory in your favourite text editor.
```

## カスタムキーコードを追加する

QMK Firmwareのカスタムキーコードのページを参考に、keymap.cに追加します。
KEYMAP.JSNから指定できるようにするには、`custum_keys_user`にカスタムキーコードとそれを表す文字列を追加してください。

メンバ名|役割
---|---
start_kc|最初のカスタムキーコードの値
end_kc|最後のカスタムキーコードの値
key_strings|カスタムキーコードを表す文字列。`'\0'`で区切って順番に追加してください
