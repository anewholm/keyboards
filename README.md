# Kurdish keyboard layouts for Linux

![Human made content](human-made-content.png "Human made content")
[![CI](https://github.com/anewholm/keyboards/actions/workflows/ci.yml/badge.svg)](https://github.com/anewholm/keyboards/actions/workflows/ci.yml)

Hybrid Kurdish (Kurmanjî Latin/Qamişlo) keyboard layouts for Ubuntu and other Linux distributions using XKB. Each layout merges Kurdish characters into an existing base keyboard layout, so you keep your familiar key positions while gaining Kurdish input.

## Supported base layouts

| File | Base layout |
|------|-------------|
| `ku-us` | US QWERTY |
| `ku-gb` | UK QWERTY |
| `ku-de` | German QWERTZ |
| `ku-fi` | Finnish |
| `ku-iq` | Arabic (Iraq) |

## Key mappings

Kurdish characters are mapped to the following positions (row-column):

| Position | Key |
|----------|-----|
| E-00 (§ / ½) | ş |
| E-12 (´) | î |
| D-11 | û |
| C-10 | ç |
| C-11 | ê |

## Installation

```bash
sudo bash install.sh
```

The script:
1. Detects your current keyboard layout.
2. Copies the matching `ku-*` file (and all variants) into `/usr/share/X11/xkb/symbols/`.
3. Injects the Kurdish layout names into `/usr/share/X11/xkb/rules/evdev.xml` (backs up the original as `evdev.xml-old`).

If your base layout is not yet supported, the script installs the files anyway — you can set the layout manually afterwards.

## Enabling the layout

After installation, add the Kurdish layout via your desktop settings:

**KDE / KUbuntu:**
> System Settings → Input Devices → Keyboard → Layouts → Add → search "Kurdish"

**GNOME / Ubuntu:**
> Settings → Keyboard → Input Sources → + → Other → Kurdish

## Uninstall

Remove the `ku-*` files from `/usr/share/X11/xkb/symbols/` and restore `evdev.xml` from the `evdev.xml-old` backup that the installer creates automatically.

## Compatibility

| Distribution | Versions | Status |
|---|---|---|
| Ubuntu | 22.04, 24.04 | Tested in CI |
| KUbuntu | 22.04, 24.04 | Tested in CI (same packages as Ubuntu) |
| Linux Mint | 21, 22 | Tested in CI |
| Fedora | 40, 41 | Tested in CI |
| Kali Linux | rolling, last-release | Tested in CI |
| Debian / other Debian-based | — | Should work (same XKB path) |

The XKB symbols directory (`/usr/share/X11/xkb/symbols/`) is at the same path on all tested distributions.

**Wayland:** XKB layouts work under both X11 and Wayland. On Wayland (GNOME 45+, KDE Plasma 6), add the layout through the same Settings → Keyboard path — no additional steps required.

## License

MIT
