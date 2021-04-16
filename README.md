# Custom repository for suckless and some other tools I use

## Repository contents

This is my self-made xbps repo of my builds of some suckless tools ([suckless.org](https://suckelss.org)) and some other cool stuff tweaked for my own needs.

The main purpose was to have an ability to install custom `dmenu` replacing standard repo version.

Included in the repo are:
- `bspswallow`, by @JopStro
    - Just packaged for the ease of installation. Both main and alternative versions included.
- `dmenu`, ver. 5.0
- `dmenu_drun`, ver. 1.0(2), by @d9d6ka
    - My self-written python version of {i3,j4}-dmenu-desktop.
- `dwm`, ver. 6.2
- `st`, ver. 0.8.4
- `xdgmenumaker`, ver. 1.6, by @gapan
    - I've allowed IceWM to use svg icons as the version in the standard repo allows it

You should have [Fira Code](https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip) and `FiraCode Nerd Font` already installed on your system to use my suckless tools builds.

## Suckless tools dependencies (for manual install)

### st

```bash
apt install libx11-dev x11proto-core-dev libxft-dev
xbps-install -S base-devel fontconfig-devel ncurses libX11-devel libXft-devel
```
### surf

```bash
apt install libwebkit2gtk-4.0-dev libglib2.0-dev libgtk2.0-dev libgcr-3-dev
xbps-install -S webkit2gtk webkit2gtk-devel gcr-devel gtk+3-devel
```

### dwm

```bash
apt install libx11-dev x11proto-core-dev libxft-dev libxinerama-dev
xbps-install -S base-devel ncurses libX11-devel libXft-devel libXinerama-devel
```

Dependencies for `swallow` patch:

```bash
sudo apt install libx11-xcb-dev libxcb-res0-dev
```

All included layouts are manually patched to allow the effects of the `tilegap` patch in them (not in the `tile` layout only).

Add `dwm` to display manager:

```bash
sudo tee -a /usr/share/xsessions/dwm.desktop > /dev/null <<EOT
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOT
```

### dwmblocks

`dwmblocks` by [@torrinfail](https://github.com/torrinfail/dwmblocks).

### sxiv

```bash
git clone https://github.com/muennich/sxiv
xbps-install imlib2-devel libexif-devel giflib-devel
```
