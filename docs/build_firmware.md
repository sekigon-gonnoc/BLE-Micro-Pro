# ファームウェアをビルドする

ファームウェアのビルド方法などは基本的にQMKそのものです。ここでは、BLE Micro Proに特有の手順のみ説明します。

- [環境構築](#環境構築)
  - [ビルドする](#ビルドする)
    - [uf2ファイルを生成する](#uf2ファイルを生成する)
    - [nrfutilで書き込む](#nrfutilで書き込む)
  - [新しいキーボードのフォルダをつくる](#新しいキーボードのフォルダをつくる)
  - [カスタムキーコードを追加する](#カスタムキーコードを追加する)

## 環境構築

QMKの導入手順にしたがって必要ソフトをインストールしてください。
Pro Microを使う場合とは異なり、`arm-none-eabi-gcc`とその関連ソフトも必須です。
なお、submoduleのlufaやChibiOSには依存していないため、これらの導入は飛ばしても構いません。

- BLE Micro Pro用のQMK Firmwareを`qmk_firmware_bmp`という名前でクローンします。

  ``` 
  git clone --depth 1 -b dev/ble_micro_pro https://github.com/sekigon-gonnoc/qmk_firmware.git qmk_firmware_bmp
  ```

- ビルドに必要なツールをインストールします。
  ```
  cd qmk_firmware_bmp
  ./util/qmk_install.sh
  ```

- uf2ではなくnrfutilを使って書き込む場合、追加でnrfutilもインストールします。
  ```
  pip install nrfutil --user
  ```

### ビルドする

#### uf2ファイルを生成する
以下のコマンドでuf2ファイルが生成されます。

```
  make ble_micro_pro:default:uf2
```

または

```
  make <keyboard>:<keymap>:uf2
```

次にブートローダを起動してください。リセットボタンを押しながらUSBケーブルで接続する、[CLI](cli.md)からdfuコマンドを発行する、リセットボタンを長押しする（ver0.4から）のいずれかにより行なえます。

最後にブートローダ起動後に出てくる外部メディア(BLEMICROPROと名前がついているもの)へ生成されたuf2ファイルをコピーすることでファームウェアがアップデートされます。

#### nrfutilで書き込む

以下のコマンドでnrfutil用のzipファイルを生成し、書き込み待機状態になったらBLE Micro Proのブートローダを起動します。
ブートローダを起動するには、リセットボタンを押しながらUSBケーブルで接続する、[CLI](cli.md)からdfuコマンドを発行する、リセットボタンを長押しする（ver0.4から）のいずれかをおこなってください。

```
  make <keyboard>:<keymap>:nrfutil
```

### 新しいキーボードのフォルダをつくる

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

### カスタムキーコードを追加する

QMK Firmwareのカスタムキーコードのページを参考に、keymap.cに追加します。
KEYMAP.JSNから指定できるようにするには、`custum_keys_user`にカスタムキーコードとそれを表す文字列を追加してください。

メンバ名|役割
---|---
start_kc|最初のカスタムキーコードの値
end_kc|最後のカスタムキーコードの値
key_strings|カスタムキーコードを表す文字列。`'\0'`で区切って順番に追加してください