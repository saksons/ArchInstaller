echo $(lsblk)

read disk

parted /dev/$disk mklabel gpt

echo "[+] EFI"
parted -a opt /dev/$disk mkpart primary ext4 0% 1GB
echo "[+] SWAP"
parted -a opt /dev/$disk mkpart primary ext4 1GB 5GB
echo "[+] VAR"
parted -a opt /dev/$disk mkpart primary ext4 5GB 16GB
echo "[+] HOME"
parted -a opt /dev/$disk mkpart primary ext4 16GB 40%
echo "[+] ROOT"
parted -a opt /dev/$disk mkpart primary ext4 40% 100%