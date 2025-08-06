#!/bin/bash

# package-installer.sh

# Purpose: Package install script for arch. Installs all packages in 'packages' 
# array which comes from packages.sh while excluding all packages from the 
# 'excluded_packages' array.

# The array of packages is called "packages" this contains all packages that are
# not amd or intell specific. amd specific will be called 'amd_packages' and
# intell specific packges intell_packages. There is also an array of packages
# which should not be included in the install script called 'excluded_packages'

source ~/dotfiles/packges/.config/packages/packages.sh # contains arrays: packges, intel_packages, amd_packages and excluded_packages

get_cpu_make() {
  local cpu_maker=""
  while [[ "$cpu_maker" != "amd" && "$cpu_maker" != "intel" ]]; do
    read -rp "Enter your CPU maker ('amd' or 'intel'): " cpu_maker
    cpu_maker=${cpu_maker,,}
  done
  echo "$cpu_maker" # This is return value 
}

# Installs yay along with pakcages needed for yay
install_yay() {
  local user_input=""
  while [[ "$user_input" != "yes" && "$user_input" != "no" ]]; do
    read -rp "Would you like to install yay? ('yes' or 'no'): " user_input
  done

  if [[ "$user_input" == "yes" ]]; then
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay || return
    makepkg -si
  fi
}

# Trys installing packages with yay
# Add --noconfirm flag to avoid confirmations
install_with_yay() {
  local package_name="$1"
  if yay -S --needed "$package_name"; then
    echo "$package_name installed successfully with yay"
  else 
    echo "$package_name failed with yay"
  fi
}

# Trys installing packages with pacman, if fails trys yay.
# Add --noconfirm flag to avoid confirmations
install() {
  local packages_parm=("$@")
  for package in "${packages_parm[@]}"; do
    if sudo pacman -S --needed "$package"; then
      echo "$package installed successfully"
    else
      echo "$package install failed. Trying yay..."
      install_with_yay "$package"
    fi
  done
}

install_cpu_packages() {
  local user_input="";
  while [[ "$user_input" != "yes" && "$user_input" != "no" ]]; do
    read -rp "Would you like to proceed to the cpu packages installer menu ('yes' or 'no'):"
  done

  if [[ "$user_input" == "yes " ]]; then
    local cpu_maker=$(get_cpu_make)
  
    if [[ "$cpu_maker" == "intel" ]]; then
      install "${intel_packages[@]}"
    else
      install "${amd_packages[@]}"
    fi
  fi
}

install_general_pkgs() {
  install "${packges[@]}"
}

main() {
  install_yay
  install_cpu_packages
  install_general_pkgs

}

main

