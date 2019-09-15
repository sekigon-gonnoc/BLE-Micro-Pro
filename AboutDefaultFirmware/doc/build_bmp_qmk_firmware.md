# BLE Micro Pro用QMKファームウェアのビルド

## get source code

```
git clone --depth 1 -b nrf52/ble_micro_pro https://github.com/sekigon-gonnoc/qmk_firmware.git qmk_firmware_bmp
```

## install build tools
- Install `arm-none-eabi-gcc` and related tools via `util/qmk_install.sh`

- Install `nrfutil` via `pip2`  or download [nrfutil.exe](https://github.com/NordicSemiconductor/pc-nrfutil/releases) to ~/qmk_utils (windows only).

## Build and write firmware
```
  make <keyboard>:<keymap>:nrfutil
```