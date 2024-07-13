lsblk

read -p "Укажите диск: " disk
read -p "Продожить? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

parted /dev/$disk mklabel gpt

echo "[+] EFI"
parted -a opt /dev/$disk mkpart primary ext4 0% 1024MiB > /dev/null
echo "[+] SWAP"
parted -a opt /dev/$disk mkpart primary ext4 1024MiB 5120MiB > /dev/null
echo "[+] VAR"
parted -a opt /dev/$disk mkpart primary ext4 5MiB 16384MiB > /dev/null
echo "[+] HOME"
parted -a opt /dev/$disk mkpart primary ext4 16384MiB 40% > /dev/null
echo "[+] ROOT"
parted -a opt /dev/$disk mkpart primary ext4 40% 100% > /dev/null