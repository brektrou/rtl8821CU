#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must run this with superuser priviliges.  Try \"sudo ./dkms-install.sh\"" 2>&1
  exit 1
else
  echo "About to run dkms install steps..."
fi


DRV_DIR=`pwd`
DRV_NAME=rtl8821CU
DRV_VERSION=5.4.1

cp -r ${DRV_DIR} /usr/src/${DRV_NAME}-${DRV_VERSION}

dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
dkms install -m ${DRV_NAME} -v ${DRV_VERSION}
RESULT=$?

echo "Finished running dkms install steps."

echo "Installing usb_modeswitch rule at /usr/lib/udev/rules.d/41-usb_modeswitch_rtl8821CU.rules"

command -v usb_modeswitch >/dev/null 2>&1 || { echo >&2 "You may wish to install usb_modeswitch \
to automatically enable wi-fi mode"; }

cat <<EOF > /usr/lib/udev/rules.d/41-usb_modeswitch_rtl8821CU.rules
# Part of the rtl8821CU dkms driver installation
ACTION!="add|change", GOTO="modeswitch_rules_end"
SUBSYSTEM!="usb", ACTION!="add",, GOTO="modeswitch_rules_end"
# Realtek 8821CU Wifi AC USB
ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="usb_modeswitch '/%k'"
LABEL="modeswitch_rules_end"
EOF

udevadm control --reload-rules && udevadm trigger

if grep -q -e "^CONFIG_DISABLE_IPV6 = y$" "$DRV_DIR/Makefile" ; then
	if echo "net.ipv6.conf.all.disable_ipv6 = 1
  net.ipv6.conf.default.disable_ipv6 = 1
  net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf; then
		echo "Disabled IPv6 Successfuly "
		sysctl -p
	else
		echo "Could not disable IPv6"
	fi
fi

exit $RESULT
