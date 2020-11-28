# suckless

Fonts are downloaded from:
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) by @ryanoasis
- [Font Awesome 4](https://github.com/FortAwesome/Font-Awesome/archive/v4.7.0.tag.gz) by @FortAwesome
- [Fira Code](https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip) by @tonsky

## st

```bash
apt install libx11-dev x11proto-core-dev libxft-dev
xbps-install -S base-devel fontconfig-devel ncurses libX11-devel libXft-devel
```
## surf

```bash
apt install libwebkit2gtk-4.0-dev libglib2.0-dev libgtk2.0-dev libgcr-3-dev
xbps-install -S webkit2gtk webkit2gtk-devel gcr-devel gtk+3-devel
```

## dwm

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
