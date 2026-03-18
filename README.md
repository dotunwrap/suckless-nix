<div align = center>

# Gabby's Nix-ified Suckless Software

[![Badge Nix]][Nix]
[![Badge X]][Follow X]

</div>

Nix flake for building patched [suckless](https://suckless.org/) tools: **dwm**, **dwmblocks**, and **slock**.

## Packages

### dwm (6.6)

Dynamic window manager for X with the following patches applied:

- `vanitygaps` — inner/outer gaps around windows
- `colorbar` — colored status bar segments
- `statuscmd` — clickable status bar blocks
- `swallow` — terminal window swallowing
- `stacker` — stack-based window ordering keybinds
- `focusmaster-return` — focus master window and return
- `preventfocusshift` — prevent focus shifting on map/unmap
- `sticky` — sticky windows across tags
- `focusmonmouse` — focus monitor under mouse
- `focusfullscreen` — prevent focus from going behind fullscreen windows
- `fixmultimon` — multimonitor fix
- `restartsig` — restart dwm without killing X
- `spawntag` — spawn windows on a specific tag
- `hide_vacant_tags` — hide tags with no windows
- `xrdb` — read colors from Xresources

### dwmblocks

Modular status bar for dwm with blocks for:

- Weather (updates every 30 min)
- Memory usage (every 30s)
- Network (every 5s)
- Audio volume (every 1s)
- Battery (every 1s)
- Date/time (every 5s)

### slock (1.6)

Simple X display locker with the following patch applied:

- `xresources` — read colors from Xresources

## Usage

Build a specific package:

```sh
nix build .#dwm
nix build .#dwmblocks
nix build .#slock
```

Enter the dev shell (provides `gcc` for patch development):

```sh
nix develop
```

## Structure

```
.
├── flake.nix
├── dwm/
│   ├── patches/          # upstream .diff patches
│   └── src-patched/      # patched dwm source
├── dwmblocks/
│   ├── patches/
│   └── src-patched/      # patched dwmblocks source + scripts
└── slock/
    ├── patches/
    └── src-patched/      # patched slock source
```

Patches are applied manually in the order listed in each `patches/patch-order.txt`, then committed to `src-patched/`.

<!---->

[Nix]: https://nixos.org
[Follow X]: https://twitter.com/intent/user?screen_name=dotunwrap
[Badge Nix]: https://img.shields.io/badge/-nix_btw-75afd7?logo=nixos&logoColor=CAD3F5&labelColor=24273A
[Badge X]: https://img.shields.io/twitter/follow/dotunwrap
