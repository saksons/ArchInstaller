echo $(lsblk)

read disk

parted /dev/$disk mklabel gpt

echo "[+] EFI"
parted -a opt /dev/$disk mkpart primary ext4 0 2097152
echo "[+] SWAP"
parted -a opt /dev/$disk mkpart primary ext4 2097153 10485761
echo "[+] VAR"
parted -a opt /dev/$disk mkpart primary ext4 10485761 31457282
echo "[+] HOME"
parted -a opt /dev/$disk mkpart primary ext4 40%
echo "[+] ROOT"
parted -a opt /dev/$disk mkpart primary ext4 100%