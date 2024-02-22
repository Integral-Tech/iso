#!/bin/bash

enable_service connman
enable_service greetd
enable_user_service pipewire-pulse

adduser ewe video
adduser ewe input
adduser ewe audio
adduser greeter video
adduser greeter input

cat <<EOF >/etc/greetd/config.toml
[terminal]
vt=1

[default_session]
command = "Hyprland"
user = "ewe"
EOF

mkdir -p /home/ewe/.config/hypr /home/ewe/.config/foot
cp /usr/share/hyprland/hyprland.conf /home/ewe/.config/hypr/hyprland.conf
sed -i 's/autogenerated=1//; s/kitty/foot/; s/wofi --show drun/rofi -show drun -show-icons -terminal foot/; /dwindle {/a no_gaps_when_only = 1' \
	/home/ewe/.config/hypr/hyprland.conf
cp -r /etc/xdg/foot/foot.ini /home/ewe/.config/foot/foot.ini
sed -i 's/# alpha=1.0/ alpha=0.3/' /home/ewe/.config/foot/foot.ini
cp -r /etc/xdg/waybar /home/ewe/.config/waybar
sed -i 's/sway/hyprland/' /home/ewe/.config/waybar/config
cat <<EOF >>/home/ewe/.config/hypr/hyprland.conf
exec-once = waybar & swww init
EOF
chown ewe:ewe -R /home/ewe/.config
