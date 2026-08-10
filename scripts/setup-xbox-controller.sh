#!/usr/bin/env bash
set -euo pipefail

CONF=/etc/modprobe.d/xpadneo-bluetooth.conf

if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

if ! pacman -Q xpadneo-dkms &>/dev/null; then
    echo "Installing xpadneo-dkms..."
    sudo -u "${SUDO_USER:-$USER}" yay -S --needed --noconfirm xpadneo-dkms
fi

echo "Writing $CONF"
cat > "$CONF" <<'EOF'
options bluetooth disable_ertm=1
EOF

echo "Disabling ERTM at runtime"
echo 1 > /sys/module/bluetooth/parameters/disable_ertm

echo "Reloading hid_xpadneo"
modprobe -r hid_xpadneo 2>/dev/null || true
modprobe hid_xpadneo

echo
echo "ERTM: $(cat /sys/module/bluetooth/parameters/disable_ertm)  (Y = disabled)"
echo "xpadneo: $(lsmod | grep -c hid_xpadneo) module(s) loaded"
echo
echo "Now: unpair the controller in bluetoothctl, then re-pair:"
echo "  1. Hold Xbox button + pair button until logo flashes fast"
echo "  2. bluetoothctl -- scan on; pair <MAC>; trust <MAC>; connect <MAC>"
