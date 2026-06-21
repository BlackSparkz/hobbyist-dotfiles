--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.workspace_rule({ workspace = "2", layout = "scrolling" })
hl.workspace_rule({ workspace = "3", layout = "dwindle" })

hl.window_rule({
  name   = "float-file-pickers",
  match  = { title = "^(Open File|Open Folder|Open|Save|Save As|Export|Import|Choose File|Rename)$" },
  float  = true,
  center = true,
  decorate = false
})

hl.window_rule({
  name  = "pip n kdeconnect daemon popups",
  match = { title = "Picture-in-Picture|Picture in picture" },
  match = { class = "org.kde.kdeconnect.handler|org.kde.kdeconnect.daemon" },
  float = true,
  move = {1470,820},
  opacity = "1.0",
  border_size = 2,
  pin = true,
  keep_aspect_ratio = true,
  size = {"(monitor_w*0.22)","(monitor_h*0.22)"},
  no_initial_focus = true,
})

hl.layer_rule({
  name  = "Essential blur",
  match = { namespace = "logout_dialog|rofi|quickshell" },
  blur = true,
  ignore_alpha = 0,
})

hl.layer_rule({
  name  = "waybar",
  match = { namespace = "waybar" },
  blur = true,
  blur_popups = false,
  ignore_alpha = 0,
  animation = "slide top",
})

hl.layer_rule({
  name  = "mako",
  match = { namespace = "notifications" },
  blur = true,
  ignore_alpha = 0,
  animation = "slide right",
})

hl.layer_rule({
  name      = "no-anim-for-selection",
  match     = { namespace = "selection" },
  no_anim   = true,
})

hl.window_rule({
  name  = "Dashboard",
  match = { class = "dashboard" },
  -- animation = "slide right",
  float = true,
  border_size = 3,
  no_initial_focus = false,
  move = {1260,730},
  opacity = "1.0",
  pin = true,
  size = {"(monitor_w*0.33)","(monitor_h*0.30)"},
})

hl.window_rule({
  name  = "Cava window rule",
  match = { class = "cava" },
  float = true,
  no_blur = true,
  rounding = 0,
  border_size = 0,
  no_initial_focus = true,
  move = {6,888},
  opacity = "1.0",
  pin = true,
  size = {"(monitor_w*1.00)","(monitor_h*0.18)"},
})


hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

local suppressMaximizeRule = hl.window_rule({
  name  = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name  = "Floating windows",
  match = { class = "sensors|bluetui|thunar|nwg-look|org.kde.kdeconnect.sms|aichat|nmtui|battery|pulsemixer|org.gnome.Nautilus|org.kde.kdeconnect.app|localsend" },
  float = true,
  no_initial_focus = false,
  border_size = 2,
  move = {960,510},
  opacity = "1.0",
  pin = true,
  decorate = false,
  size = {"(monitor_w*0.48)","(monitor_h*0.50)"},
})
