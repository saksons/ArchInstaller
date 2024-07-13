# Disk parter

lsblk

read -p "Choose disk: " disk
read -p "Continue? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

parted /dev/$disk mklabel gpt > /dev/null 2>&1

echo "[+] EFI"
parted -a opt /dev/$disk mkpart primary fat32 0% 1024Mb > /dev/null 2>&1
echo "[+] swap"
parted -a opt /dev/$disk mkpart primary linux-swap 1024Mb 5120Mb > /dev/null 2>&1
echo "[+] home"
parted -a opt /dev/$disk mkpart primary ext4 5120Mb 50% > /dev/null 2>&1
echo "[+] root"
parted -a opt /dev/$disk mkpart primary ext4 50% 100% > /dev/null 2>&1

parted /dev/sda print


# Mounting && swpaon

mount /dev/sda4 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home

swapon /dev/sda2


# Package installing

pacstrap -i /mnt base base-devel linux linux-firmware linux-headers sudo networkmanager efibootmgr


# Update FStab

genfstab -U -p /mnt >> /mnt/etc/fstab


# Chrooting

arch-chroot /mnt /bin/bash


# Configuring

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwcloc --systohc --utc

echo SSA > /etc/hostname

echo -e "127.0.0.1\tlocalhost.localdomain\tSSA"

systemctl enable NetworkManager

useradd -m -g user -G wheel -s /bin/bash soks
passwd soks

sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL' /etc/sudoers