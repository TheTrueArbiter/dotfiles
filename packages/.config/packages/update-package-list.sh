#!/bin/bash

# update-package-list.sh

# Purpose: update the array of package names in packages.sh so when the install
# script is ran, package-installer.sh, it will contain the most recent packages
# on your system

SCRIPT_DIR="$HOME/dotfiles/packages/.config/packages/"
source "$SCRIPT_DIR/packages.sh" # contains arrays: packges, intel_packages, amd_packages


new_packages=()
old_packages=("${packages[@]}") # old list of packages

get_packages() {
 pacman -Qe | awk '{print $1}'
}

# Adds packages which should not be included in the packges array ie the
# general packages. These packages are added to the old array of packages so
# when they are check for existing ones theyll be found

add_exclueded_pkgs() {
  local -n cpu_packages=$1
  for package in "${cpu_packages[@]}"; do
    old_packages+=("$package")
  done
}

# Saves updated array of package names to packages.sh.
# Rewrites packages.sh to a temporary file, packages.sh.tmp, inserting the new
# 'packages=(' array (replaces the entire array block, not efficient).
# Creates a backup of the original packages.sh, then replaces it with the updated version.

save_packages() {
  tmp_file="$SCRIPT_DIR/packages.sh.tmp"
  inside_packages=0    # Flag: Are we inside the packages=( ... ) block?
  packages_written=0   # Flag: Have we already written the new array?

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^packages=\( ]]; then
      # Start writing the updated array
      echo "packages=(" >> "$tmp_file"
      for pkg in "${packages[@]}"; do
        echo "  \"$pkg\"" >> "$tmp_file"
      done
      echo ")" >> "$tmp_file"

      inside_packages=1   # Begin skipping the old array block
      packages_written=1  # Mark that we inserted our own version
      continue             # Skip writing the original 'packages=(' line
    fi

    # If we're inside the original array block, skip lines until we hit the closing ')'
    if [[ $inside_packages -eq 1 ]]; then
      if [[ "$line" =~ ^\)[[:space:]]*$ ]]; then
        inside_packages=0  # Done skipping the old array
      fi
      continue
    fi

    # For all other lines, just copy them as-is
    echo "$line" >> "$tmp_file"
  done < "$SCRIPT_DIR/packages.sh"

  # Back up the original file
  cp "$SCRIPT_DIR/packages.sh" "$SCRIPT_DIR/packages.sh.bak"

  # Replace the original with the updated version
  mv "$tmp_file" "$SCRIPT_DIR/packages.sh"
}


add_new_packages(){
  mapfile -t new_packages < <(get_packages)

  add_exclueded_pkgs intel_packages
  add_exclueded_pkgs amd_packages
  add_exclueded_pkgs excluded_packages 

  declare -i packages_found=0

  for p_new in "${new_packages[@]}"; do 
    found=false

    for p_old in "${old_packages[@]}"; do
      if [[ "$p_new" == "$p_old" ]]; then
        found=true
        break
      fi
    done
    
    if [[ "$found" == false ]]; then
      echo "$p_new -->  new package found."
      packages_found+=1
      packages+=("$p_new")
    fi
  done

  if [[ packages_found == 0 ]]; then
    echo "No new packages found."
  else
    echo "Saving new packages to packages.sh"
    save_packages
  fi
}


add_new_packages
save_packages


