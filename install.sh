lsblk

read -p "choose disk: " disk
read -p "Continue? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

parted /dev/$disk mklabel gpt > /dev/null 2>&1

echo "[+] EFI"
parted -a opt /dev/$disk mkpart primary ext4 0% 1024Mb > /dev/null 2>&1
echo "[+] swap"
parted -a opt /dev/$disk mkpart primary ext4 1024Mb 5120Mb > /dev/null 2>&1
echo "[+] var"
parted -a opt /dev/$disk mkpart primary ext4 5120Mb 16384Mb > /dev/null 2>&1
echo "[+] home"
parted -a opt /dev/$disk mkpart primary ext4 16384Mb 50% > /dev/null 2>&1
echo "[+] root"
parted -a opt /dev/$disk mkpart primary ext4 50% 100% > /dev/null 2>&1

parted /dev/sda print