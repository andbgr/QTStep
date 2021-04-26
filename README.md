## About
This is a theme suite for LXQt or KDE inspired by the WindowMaker/GNUStep/NextStep look. It consists of KWin/Aurorae and xfwm4 window decorations, LXQt and Plasma desktop themes, Qt/Kvantum widget styles, and sddm login themes.

## How to create a new variation of this theme:

1) go to (aurorae|kvantum|lxqt|plasma|xfwm4|sddm)/QTStep.source

2) Create a new colors.[NAME], either manually or automatically from a KDE color scheme, like:
	./make_color_scheme.sh ~/.local/share/color-schemes/[NAME].colors

3) Run:
       ./make_theme.sh colors.[NAME]

## Screenshots:
These mostly show lxqt-panel as it allows for more customization compared to plasma
![OpenStep](screenshots/desktop_openstep.png?raw=true "OpenStep")
![WontonSoupBrown](screenshots/desktop_wontonsoupbrown.png?raw=true "WontonSoupBrown")
![WMakerOpenStep](screenshots/desktop_wmakeropenstep.png?raw=true "WMakerOpenStep")
![RC3](screenshots/RC3.png?raw=true "RC3")
![SDDM](screenshots/sddm_full.png?raw=true "SDDM")

