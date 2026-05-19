#!/usr/bin/env bash

set -euo pipefail

printf "[+] Starting Arch setup...\n"

printf "[+] Installing base packages...\n"
sudo pacman -S --needed --noconfirm base-devel stow fish eza git

printf "[+] Verifying whether yay is installed or not...\n"
if ! command -v yay &>/dev/null; then
  printf "[!] yay not found\n"
  printf "[+] Installing yay...\n"
  tmpdir=$(mktemp -d)
  trap 'rm -rf "$tmpdir"' EXIT
  git clone https://aur.archlinux.org/yay-bin.git "$tmpdir/yay-bin"
  (cd "$tmpdir/yay-bin" && makepkg -si --noconfirm)
else
  printf "[=] yay already installed\n"
fi

printf "[+] Creating config directories...\n"
mkdir -p ~/.local/share/fonts

DOTFILES="$HOME/hobbyist-dotfiles"

if [ -d "$DOTFILES" ]; then
  printf "[+] Applying dotfiles...\n"
  bash "$DOTFILES/stow-configs.sh"

  printf "[+] Copying fonts and wallpapers...\n"
  cp -r "$DOTFILES/Configs/Resources/fonts/." ~/.local/share/fonts/
  cp -r "$DOTFILES/Wallpapers" ~/

  pkglist="$DOTFILES/Configs/installed-pkg/pkglist.txt"
  if [ -f "$pkglist" ]; then
    printf "[+] Installing packages from list...\n"

    if pacman -Qi niri &>/dev/null && grep -q '^niri-git$' "$pkglist"; then
      printf "[!] Conflict: stable 'niri' is installed, pkglist has 'niri-git'.\n"
      printf "    [1] Remove stable niri and install niri-git\n"
      printf "    [2] Skip niri-git, keep stable niri\n"
      read -rp "    Choice [1/2]: " niri_choice
      if [[ "$niri_choice" == "1" ]]; then
        sudo pacman -Rns --noconfirm niri
      else
        _filtered=$(mktemp)
        grep -v '^niri-git$' "$pkglist" > "$_filtered"
        pkglist="$_filtered"
      fi
    fi

    xargs yay -S --needed --answerclean All --answerdiff None --noconfirm \
      < "$pkglist"
  fi

else
  printf "[!] Dotfiles repo not found at $DOTFILES — skipping dotfiles, resources, and package list.\n"
fi

if command -v fish &>/dev/null; then
  printf "[+] Setting fish as default shell...\n"
  chsh -s "$(command -v fish)"
fi

if ! pacman -Q bluez bluez-utils &>/dev/null; then
  yay -S --needed --answerclean All --answerdiff None --noconfirm bluez bluez-utils && printf "bluez and bluez-utils installed successfully\n"
fi

init=$(ps -p 1 -o comm=)
if [[ "$init" == "systemd" ]]; then
  printf "[+] Enabling Bluetooth...\n"
  sudo systemctl enable --now bluetooth.service
  sudo rfkill unblock bluetooth || true

  printf "[+] Setting Niri as default...\n"
  if [[ -f "$HOME/.config/systemd/user/niri.service" ]]; then
    systemctl --user daemon-reload
    systemctl --user enable --now niri.service
  fi

  printf "[+] Enabling mako sound...\n"
  if [[ -f "$HOME/.config/systemd/user/mako-sound.service" ]]; then
    systemctl --user daemon-reload
    systemctl --user enable --now mako-sound.service
  fi

else
  printf "[!] Skipping....\n"
  printf "[!] System is not running on $init\n"
fi

printf "[+] Fixing bash config\n"
if [[ -f "$HOME/.config/Scripts/bashfix.sh" ]]; then
  bash "$HOME/.config/Scripts/bashfix.sh"
else
  printf "bashfix not found\n"
fi

printf "[+] Installing WhiteSur icon pack...\n"
cd ~
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd ~/WhiteSur-icon-theme
bash install.sh
rm -rf ~/WhiteSur-icon-theme/

printf "[✓] Setup completed successfully!"
