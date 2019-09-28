# BLE Micro Pro用QMKファームウェアのビルド

## get source code

```
git clone --depth 1 -b dev/ble_micro_pro https://github.com/sekigon-gonnoc/qmk_firmware.git qmk_firmware_bmp
```

## install build tools
- Install `arm-none-eabi-gcc` and related tools via `util/qmk_install.sh`

- Install `nrfutil` via `pip2`  or download [nrfutil.exe](https://github.com/NordicSemiconductor/pc-nrfutil/releases) to ~/qmk_utils (windows only).

## Build and write firmware
### uf2
 `:uf2` option convert `.bin` file to `.uf2` file and copy it to uf2 drive if found.  
 Put your BLE Micro Pro into dfu mode `before` do following command if you want copy uf2 file automatically.  
 BLE Micro Pro start dfu mode if it is plugged during level of BOOT pin is low (reset switch of keyboard is pushed) or jump from application (BOOTLOADER keycode or [CLI](cli.md)).

- Default firmware
```
  make ble_micro_pro:default:uf2
```

- Your own firmware
```
  make <keyboard>:<keymap>:uf2
```

### nrfutil
 `:nrfutil` option convert `.bin` file to `.zip` file and burn it to BLE Micro Pro if found.  
 Put your BLE Micro Pro into dfu mode `after` do following command if you want burn firmware automatically.
 BLE Micro Pro start dfu mode if it is plugged during level of BOOT pin is low (reset switch of keyboard is pushed) or jump from application (BOOTLOADER keycode or [CLI](cli.md)).

- Default firmware
```
  make ble_micro_pro:default:nrfutil
```

- Your own firmware
```
  make <keyboard>:<keymap>:nrfutil
```
