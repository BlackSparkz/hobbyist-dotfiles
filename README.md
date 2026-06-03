# Hobbyist dotfiles

## MangoWM
> [MangoWM](https://github.com/mangowm/mango) is as lightweight as dwl and can be built completely within a few seconds. Despite this, Mango does not compromise on functionality.

## Niri
> [Niri](https://github.com/YaLTeR/niri) is a scrollable-tiling Wayland compositor written in Rust. It offers a unique approach to window management compared to traditional tiling compositors.

## Hyprland
> [Hyprland](https://github.com/hyprwm/Hyprland) is an independent, highly customizable, dynamic tiling Wayland compositor without sacrificing its looks.

## DriftWM
> [DriftWM](https://github.com/malbiruk/driftwm) is a trackpad-first infinite canvas Wayland compositor.


<h1>Qtile <span style="font-weight: normal;">(No Longer Maintained)</span></h1>
> [Qtile](https://github.com/qtile/qtile/) is a full-featured, hackable tiling window manager written and configured in Python

### Curious about what it looks like? Here's a glimpse.

|      **Desktop & Status Bar**      |
| :--------------------------------: |
| ![Desktop](Screenshots/waybar.png) |

|        **App launcher**         |
| :-----------------------------: |
|  ![Rofi](Screenshots/rofi.png)  |
| ![Rofi2](Screenshots/rofi2.png) |

|          **Clipboard history**          |
| :-------------------------------------: |
| ![clipboard](Screenshots/clipboard.png) |

|            **Wallpaper picker**             |
| :-----------------------------------------: |
| ![wall_picker](Screenshots/wall_picker.png) |

|                 **Power menu**                 |
| :--------------------------------------------: |
|      ![Wlogout](Screenshots/wlogout.png)       |
| ![powermenu_rofi](Screenshots/powermenu_1.png) |

|                **Screenlock**                 |
| :-------------------------------------------: |
|     ![hyprlock](Screenshots/hyprlock.png)     |
| ![hyprlock_alt](Screenshots/hyprlock_alt.png) |

|              **Fastfetch**              |
| :-------------------------------------: |
| ![fastfetch](Screenshots/fastfetch.png) |


## Components

> This setup uses the following applications and tools:

|     **Category**      | **Application**                                         | **Description**                                                                                                             |
| :-------------------: | :------------------------------------------------------ | :-------------------------------------------------------------------------------------------------------------------------- |
|  **Window Manager**   | [MangoWM](https://github.com/mangowm/mango)             | Practical and powerful Wayland compositor (dwm but Wayland)                                                                 |
|                       | [Niri](https://github.com/niri-wm/niri)                 | A scrollable-tiling Wayland compositor.                                                                                     |
|                       | [Hyprland](https://github.com/hyprwm/Hyprland)          | Highly customizable dynamic tiling Wayland compositor.                                                                      |
|                       | [DriftWM](https://github.com/malbiruk/driftwm)          | A trackpad-first infinite canvas Wayland compositor.                                                                        |
|                       | [Qtile](https://github.com/qtile/qtile/)                | A full-featured, hackable tiling window manager written and configured in Python                                            |
|    **Status Bar**     | [Waybar](https://github.com/Alexays/Waybar)             | Highly customizable modular status bar.                                                                                     |
|    **Info fetch**     | [Fastfetch](https://github.com/fastfetch-cli/fastfetch) | Fastfetch is a neofetch-like tool for fetching system information                                                           |
| **Wallpaper Manager** | [swaybg](https://github.com/swaywm/swaybg)              | Wallpaper tool for Wayland compositors.                                                                                     |
|     **Terminal**      | [Foot](https://codeberg.org/dnkl/foot)                  | A fast, lightweight and minimalistic Wayland terminal emulator                                                              |                           |
|                       | [Kitty](https://github.com/kovidgoyal/kitty)            | Fast, feature-rich, GPU-based terminal emulator.                                                                            |
|       **Shell**       | [Fish](https://fishshell.com/)                          | User-friendly command line shell.                                                                                           |
|      **Editor**       | [Neovim](https://neovim.io/)                            | Neovim is a modern, fast and feature-rich editor that is fully compatible with Vim. Powered by [NvChad](https://nvchad.com) |
|     **Launcher**      | [Rofi](https://github.com/davatorium/rofi)              | Window switcher, application launcher, and dmenu replacement.                                                               |
|  **System Monitor**   | [Btop](https://github.com/aristocratos/btop)            | A monitor of resources.                                                                                                     |
|   **File Manager**    | [Yazi](https://github.com/sxyazi/yazi)                  | Blazing-fast terminal file manager written in Rust.                                                                         |
|   **Notifications**   | [Mako](https://github.com/emersion/mako)                | Lightweight notification daemon.                                                                                            |
|    **Lock Screen**    | [Hyprlock](https://github.com/hyprwm/hyprlock/)         | Hyprland's GPU-accelerated screen locking utility.                                                                          |
|    **Logout Menu**    | [Wlogout](https://github.com/ArtsyMacaw/wlogout)        | Wayland-based logout menu.                                                                                                  |
|   **Media Player**    | [MPV](https://mpv.io/)                                  | Video player with `modernz` script.                                                                                         |
| **Audio Visualizer**  | [Cava](https://github.com/karlstav/cava)                | Console-based audio visualizer.                                                                                             |

## Essential Keybindings

> These keybindings are consistent across all listed Wayland compositors. Check each compositor's config file for the full list.

| **Key Combination**                               | **Action**                 |
| :------------------------------------------------ | :------------------------- |
| <kbd>Super</kbd> + <kbd>T</kbd>                   | Open Terminal (`Kitty`)    |
| <kbd>Super</kbd> + <kbd>Space</kbd>               | Open App Launcher (`Rofi`) |
| <kbd>Super</kbd> + <kbd>Q</kbd>                   | Quit focused window        |
| <kbd>Super</kbd> + <kbd>B</kbd>                   | Open Browser (`Librewolf`) |
| <kbd>Super</kbd> + <kbd>N</kbd>                   | Open File Manager (`Yazi`) |
| <kbd>Super</kbd> + <kbd>P</kbd>                   | Power Menu (`Wlogout`)     |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>E</kbd> | Exit Wayland compositor    |

## Installation

> Please verify the [pkglist](Configs/installed-pkg/pkglist.txt) before executing install.sh so you have an idea of what will be installed. By default, you will get Niri (Default) and Hyprland.

### Prerequisites
- Clean Arch Linux (recommended) or an Arch-based distro (e.g. EndeavourOS, Manjaro)

```bash
sudo pacman -Syu --needed --noconfirm git
```
```bash
cd ~ && git clone https://github.com/BlackSparkz/hobbyist-dotfiles.git
```
```bash
bash ~/hobbyist-dotfiles/install.sh
```
### One-liner
```bash
sudo pacman -Syu --needed --noconfirm git && cd ~ && git clone https://github.com/BlackSparkz/hobbyist-dotfiles.git && bash ~/hobbyist-dotfiles/install.sh
```

### Stow conflicts

If GNU Stow reports conflicts, use the helper directly:

```bash
bash ~/hobbyist-dotfiles/stow-configs.sh --dry-run
```

```bash
bash ~/hobbyist-dotfiles/stow-configs.sh --backup-conflicts
```

```bash
bash ~/hobbyist-dotfiles/stow-configs.sh --adopt
```

`--adopt` can overwrite existing files, so only use it when you intend to merge local state into the repo.
