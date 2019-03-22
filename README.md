# Realtek RTL8811CU/RTL8821CU USB wifi adapter driver version 5.4.1 for Linux <= 5.0.3

Before build this driver make sure `make`, `gcc`, `linux-header` and `git` have been installed.

## First, clone this repository
```
mkdir -p ~/build
cd ~/build
git clone https://github.com/brektrou/rtl8821CU.git
```
## Build and install with DKMS

DKMS is a system which will automatically recompile and install a kernel module when a new kernel gets installed or updated. To make use of DKMS, install the dkms package.

### Debian/Ubuntu:
```
sudo apt-get install dkms
```
### Arch Linux/Manjaro:
```
sudo pacman -S dkms
```
To make use of the **DKMS** feature with this project, do the following:
```
DRV_NAME=rtl8821CU
DRV_VERSION=5.4.1
sudo cp -r ~/build/${DRV_NAME} /usr/src/${DRV_NAME}-${DRV_VERSION}
sudo dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms install -m ${DRV_NAME} -v ${DRV_VERSION}
```
If you later on want to remove it, do the following:
```
DRV_NAME=rtl8821CU
DRV_VERSION=5.4.1
sudo dkms remove ${DRV_NAME}/${DRV_VERSION} --all
```
## Build and install without DKMS
Use following commands:
```
cd ~/build/rtl8821CU
make
sudo make install
```
If you later on want to remove it, do the following:
```
cd ~/build/rtl8821CU
sudo make uninstall
```
## Checking installed driver
If you successfully install the driver, the driver is installed on `/lib/modules/<linux version>/kernel/drivers/net/wireless/realtek/rtl8821cu`. Check the driver with the `ls` command:
```
ls /lib/modules/$(uname -r)/kernel/drivers/net/wireless/realtek/rtl8821cu
```
Make sure `8821cu.ko` file present on that directory

### Check with **DKMS** (if installing via **DKMS**):

``
sudo dkms status
``
