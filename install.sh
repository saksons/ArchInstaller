echo $(lsblk)

read disk

echo "[+] EFI"
parted -a gpt $disk mkpart primary ext4 0 2097152
echo "[+] SWAP"
parted -a gpt $disk mkpart primary ext4 2097153 10485761
echo "[+] VAR"
parted -a gpt $disk mkpart primary ext4 10485761 31457282
echo "[+] HOME"
parted -a gpt $disk mkpart primary ext4 40%
echo "[+] ROOT"
parted -a gpt $disk mkpart primary ext4 100%