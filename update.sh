#!/bin/bash
#set -e

# update the aur pacages
echo """############################
# Updating the aur pacages #
############################"""
sleep 1
echo

#remove the last local repo and create a new one
echo cleaning the cache
sleep 0.5

#remove all tcache content and pakages from the repo
sudo rm -rv Aur_cache

#remove the repo
sudo rm -rv x86_64/cosmos_repo*

#remove the pkgs
sudo rm -rv x86_64/paru*
sudo rm -rv x86_64/awesome*
sudo rm -rv x86_64/betterlockscreen*
sudo rm -rv x86_64/picom*
sudo rm -rv x86_64/pywal*
sudo rm -rv x86_64/xidlehook*
sudo rm -rv x86_64/calamares*
sudo rm -rv x86_64/ckbcomp*
sudo rm -rv x86_64/mkinitcpio-openswap*
sudo rm -rv x86_64/ttf-comfortaa*
sudo rm -rv x86_64/linux*

#create the folder structure
echo creating the file estructure

# work dir
mkdir -v Aur_cache

#build
mkdir -v Aur_cache/Build

#PKGBUILD
mkdir -v Aur_cache/PKGBUILD
mkdir -v Aur_cache/PKGBUILD/AwesomeWM
mkdir -v Aur_cache/PKGBUILD/AwesomeWM/Awesome
mkdir -v Aur_cache/PKGBUILD/AwesomeWM/Betterlockscreen
mkdir -v Aur_cache/PKGBUILD/AwesomeWM/Picom
mkdir -v Aur_cache/PKGBUILD/AwesomeWM/Pywal
mkdir -v Aur_cache/PKGBUILD/AwesomeWM/Xidlehook
mkdir -v Aur_cache/PKGBUILD/CosmOS-Calamares
mkdir -v Aur_cache/PKGBUILD/CosmOS-Calamares/calamares
mkdir -v Aur_cache/PKGBUILD/CosmOS-Calamares/dependency
mkdir -v Aur_cache/PKGBUILD/CosmOS-Calamares/dependency/Ckbcomp
mkdir -v Aur_cache/PKGBUILD/CosmOS-Calamares/dependency/Mkinitcpio-openswap
mkdir -v Aur_cache/PKGBUILD/CosmOS-Calamares/dependency/Ttf-comfortaa
mkdir -v Aur_cache/PKGBUILD/Paru
mkdir -v Aur_cache/PKGBUILD/Linux


###Download the lastest PKGBUILD file version
#####################################################################################################
(cd Aur_cache/PKGBUILD/AwesomeWM/Awesome && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/awesome-git.tar.gz' --output awesome-git.tar.gz && tar -xvf  awesome-git.tar.gz)
(cd Aur_cache/PKGBUILD/AwesomeWM/Betterlockscreen && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/betterlockscreen-git.tar.gz' --output betterlockscreen-git.tar.gz && tar -xvf  betterlockscreen-git.tar.gz)
(cd Aur_cache/PKGBUILD/AwesomeWM/Picom && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/picom-git.tar.gz' --output picom-git.tar.gz && tar -xvf  picom-git.tar.gz)
(cd Aur_cache/PKGBUILD/AwesomeWM/Pywal && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/pywal-git.tar.gz' --output pywal-git.tar.gz && tar -xvf  pywal-git.tar.gz)
(cd Aur_cache/PKGBUILD/AwesomeWM/Xidlehook && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/xidlehook.tar.gz' --output xidlehook.tar.gz && tar -xvf  xidlehook.tar.gz)
(cd Aur_cache/PKGBUILD/CosmOS-Calamares/calamares && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/calamares.tar.gz' --output calamares.tar.gz && tar -xvf calamares.tar.gz)
(cd Aur_cache/PKGBUILD/CosmOS-Calamares/dependency/Ckbcomp && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/aur-63a7687dffd8fe818671d4cafb8fabb79b840943.tar.gz' --output aur-63a7687dffd8fe818671d4cafb8fabb79b840943.tar.gz && tar -xvf  aur-63a7687dffd8fe818671d4cafb8fabb79b840943.tar.gz)
(cd Aur_cache/PKGBUILD/CosmOS-Calamares/dependency/Mkinitcpio-openswap && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/mkinitcpio-openswap.tar.gz' --output mkinitcpio-openswap.tar.gz  && tar -xvf mkinitcpio-openswap.tar.gz)
(cd Aur_cache/PKGBUILD/CosmOS-Calamares/dependency/Ttf-comfortaa && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/ttf-comfortaa.tar.gz' --output ttf-comfortaa.tar.gz  && tar -xvf ttf-comfortaa.tar.gz)
(cd Aur_cache/PKGBUILD/Paru && curl 'https://aur.archlinux.org/cgit/aur.git/snapshot/paru-git.tar.gz' --output paru-git.tar.gz  && tar -xvf paru-git.tar.gz)

###ading the kerel PKGBUILD
cp -rv .kernel_config/* Aur_cache/PKGBUILD/Linux

###Prepare and compile
#####################################################################################################
cp -rv Aur_cache/PKGBUILD/* Aur_cache/Build

#PARU
########
(cd ./Aur_cache/Build/Paru/paru-git && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/Paru/paru-git/*.pkg.tar.zst x86_64

#CALAMARES
#############
(cd ./Aur_cache/Build/CosmOS-Calamares/calamares/calamares && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/CosmOS-Calamares/calamares/calamares/*.pkg.tar.zst x86_64

(cd ./Aur_cache/Build/CosmOS-Calamares/dependency/Ckbcomp/aur-63a7687dffd8fe818671d4cafb8fabb79b840943 && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/CosmOS-Calamares/dependency/Ckbcomp/aur-63a7687dffd8fe818671d4cafb8fabb79b840943/*.pkg.tar.zst x86_64

(cd ./Aur_cache/Build/CosmOS-Calamares/dependency/Ttf-comfortaa/ttf-comfortaa && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/CosmOS-Calamares/dependency/Ttf-comfortaa/ttf-comfortaa/*.pkg.tar.zst x86_64

(cd ./Aur_cache/Build/CosmOS-Calamares/dependency/Mkinitcpio-openswap/mkinitcpio-openswap && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/CosmOS-Calamares/dependency/Mkinitcpio-openswap/mkinitcpio-openswap/*.pkg.tar.zst x86_64

#AWESOME WM
##############
(cd ./Aur_cache/Build/AwesomeWM/Awesome/awesome-git && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/AwesomeWM/Awesome/awesome-git/*.pkg.tar.zst x86_64

(cd ./Aur_cache/Build/AwesomeWM/Picom/picom-git && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/AwesomeWM/Picom/picom-git/*.pkg.tar.zst x86_64

(cd ./Aur_cache/Build/AwesomeWM/Pywal/pywal-git && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/AwesomeWM/Pywal/pywal-git/*.pkg.tar.zst x86_64

(cd ./Aur_cache/Build/AwesomeWM/Betterlockscreen/betterlockscreen-git && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/AwesomeWM/Betterlockscreen/betterlockscreen-git/*.pkg.tar.zst x86_64

(cd ./Aur_cache/Build/AwesomeWM/Xidlehook/xidlehook && makepkg -s --noconfirm PKGBUILD)
cp -v Aur_cache/Build/AwesomeWM/Xidlehook/xidlehook/*.pkg.tar.x86_64zst x86_64


#####################################################################################################

###Kernel compilation
read -p "do you want to compile the kernel? [y/n]: "$'\n' -s confirm
if [ $confirm == "y" ]
then
#compiles the kernel
(cd Aur_cache/Build/Linux && makepkg -s --skippgpcheck  --skipchecksums)
cp -v Aur_cache/Linux/*.pkg.tar.zst x86_64

elif [ $confirm != "n" ]
then
echo  put y or n please
exit
fi


#####################################################################################################

#creates the repo and add all the content
(cd x86_64 && repo-add ./cosmos_repo.db.tar.gz ./*)
#git add x86_64/*

# update the arch repo pkg
echo """############################
#   update arch repo pkg   #
############################"""
(cd x86_64 && sh ./update_repo.sh)

echo
echo "################################################################"
echo "###################    Update Done        ######################"
echo "################################################################"
