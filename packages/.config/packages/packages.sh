#!/bin/bash

# packages.sh

# Purpose: Hold arrays of package names which the package installer will use. 
# Seperate cpu specific packages for install and have a list of packages which 
# should be excluded.

# NOTE: intel, amd and excluded packges must be entered manualy 

intel_packages=(
    "sof-firmware"        # ← Required for most Intel laptop audio chips
    "intel-ucode" 
  )
 
amd_packages=()

excluded_packages=(
  "yay"
  "yay-debug"
  )

packages=(
  "linux"
  "linux-firmware"
  "alsa-utils"
  "base"
  "base-devel"
  "bluez"
  "bluez-utils"
  "brightnessctl"
  "dosfstools"
  "efibootmgr"
  "fd"
  "firefox"
  "git"
  "grub"
  "gvfs"
  "htop"
  "hypridle"
  "hyprland"
  "hyprlock"
  "hyprpaper"
  "kitty"
  "mtools"
  "neovim"
  "networkmanager"
  "noto-fonts-emoji"
  "nwg-look"
  "os-prober"
  "pipewire"
  "pipewire-alsa"
  "pipewire-pulse"
  "ripgrep"
  "rofi"
  "sddm"
  "starship"
  "stow"
  "sudo"
  "thunar"
  "ttf-jetbrains-mono-nerd"
  "unzip"
  "waybar"
  "wireplumber"
  "wl-clipboard"
  "wofi"
  "xclip"
  "xdg-user-dirs"
  "android-platform"
  "android-sdk"
  "android-sdk-build-tools"
  "android-sdk-cmdline-tools-latest"
  "android-sdk-platform-tools"
  "flutter"
  "7zip"
  "fzf"
  "imagemagick"
  "nodejs"
  "npm"
  "poppler"
  "yazi"
  "zoxide"
  "less"
  "obsidian"
)
