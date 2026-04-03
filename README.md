# Kurdish keyboard layouts for Linux

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

## Compatibility

Tested on Ubuntu 22.04 and 24.04. The XKB symbols directory (`/usr/share/X11/xkb/symbols/`) is at the same path on all Debian/Ubuntu-based distributions.

## License

MIT
