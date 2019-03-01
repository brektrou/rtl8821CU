# Realtek RTL8811CU/RTL8821CU version 5.4.1 USB wifi adapter driver for Linux 4.20.x

Before build this driver make sure `make`, `gcc`, `linux-header` and `git` have been installed in your system

## Build and install with DKMS

DKMS is a system which will automatically recompile and install a kernel module when a new kernel gets installed or updated. To make use of DKMS, install the dkms package.

### Debian/Ubuntu:

    sudo apt-get install dkms

### Arch Linux/Manjaro:

    sudo pacman -S dkms

To make use of the DKMS feature with this project, do the following:

    DRV_NAME=rtl8821CU
    DRV_VERSION=5.4.1
    git clone https://github.com/brektrou/rtl8821CU.git
    sudo cp -r ${DRV_NAME} /usr/src/${DRV_NAME}-${DRV_VERSION}
    sudo chown -hRv root:root /usr/src/${DRV_NAME}-${DRV_VERSION}
    sudo dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
    sudo dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
    sudo dkms install -m ${DRV_NAME} -v ${DRV_VERSION}

If you later on want to remove it again, do the following:

    DRV_NAME=rtl8821CU
    DRV_VERSION=5.4.1
    sudo dkms remove ${DRV_NAME}/${DRV_VERSION} --all

## Build and install without DKMS
Use following commands in source directory:
```
make
sudo make install
```
## Checking installed driver
Checking installed driver
```
ls /lib/modules/$(uname -r)/kernel/drivers/net/wireless/realtek/rtl8xxxu
```
Make sure `8821cu.ko` file present on that directory

## Raspberry Pi
To build this driver on Raspberry Pi you need to set correct platform in Makefile.
Change
```
CONFIG_PLATFORM_I386_PC = y
CONFIG_PLATFORM_ARM_RPI = n
CONFIG_PLATFORM_ARM_RPI3 = n
```
to
```
CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ARM_RPI = y
CONFIG_PLATFORM_ARM_RPI3 = n
```
For the Raspberry Pi 3 you need to change it to
```
CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ARM_RPI = n
CONFIG_PLATFORM_ARM_RPI3 = y
```
