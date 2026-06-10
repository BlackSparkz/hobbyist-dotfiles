-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("sleep 0.2 && bash $HOME/.config/Scripts/random_wall_on_home.sh")
  hl.exec_cmd("waybar -c ~/.config/waybar/Hyprland/config.jsonc -s ~/.config/waybar/style.css")
  hl.exec_cmd("kdeconnectd")
  hl.exec_cmd("foot", { workspace = "special:magic", follow = false })
  hl.exec_cmd("kdeconnect-indicator")
  hl.exec_cmd("foot --server")
  hl.exec_cmd("mako")
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
  hl.exec_cmd("sleep 3;paplay /usr/share/sounds/freedesktop/stereo/message.oga|notify-send --icon ~/.config/Resources/images/PFP.jpg 'Welcome back' $USER")
  hl.exec_cmd("paplay /usr/share/sounds/freedesktop/stereo/service-login.oga")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
  -- hl.exec_cmd("bash $HOME/.config/Scripts/random_wall_on_home.sh")
end)
