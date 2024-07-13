lsblk

read -p "choose disk: " disk
read -p "Продожить? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

parted /dev/$disk mklabel gpt > /dev/null 2>&1

echo "[+] EFI"
parted -a opt /dev/$disk mkpart primary ext4 0MiB 1024MiB > /dev/null 2>&1
echo "[+] swap"
parted -a opt /dev/$disk mkpart primary ext4 1024MiB 5120MiB > /dev/null 2>&1
echo "[+] var"
parted -a opt /dev/$disk mkpart primary ext4 5120MiB 16384MiB > /dev/null 2>&1
echo "[+] home"
parted -a opt /dev/$disk mkpart primary ext4 16384MiB 40% > /dev/null 2>&1
echo "[+] root"
parted -a opt /dev/$disk mkpart primary ext4 40% 100% > /dev/null 2>&1

parted /dev/sda print