------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1.0",
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
  hl.exec_cmd("bash $HOME/.config/Scripts/random_wall_on_home.sh")
  hl.exec_cmd("waybar -c ~/.config/waybar/Hyprland/config.jsonc -s ~/.config/waybar/style.css")
  hl.exec_cmd("kdeconnectd")
  hl.exec_cmd("alacritty")
  hl.exec_cmd("mako")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 4,

        col = {
            -- active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            active_border   = "rgba(ffffffff)",
            inactive_border = "rgba(00000000)",
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "master",
    },

    decoration = {
        rounding       = 24,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            passes    = 4,
            size      = 6,
            new_optimizations = true,
            xray = false,
            popups = true,
            popups_ignorealpha = 0,
            noise = 0.02,
            contrast = 1.6,
            brightness = 0.9,
            vibrancy  = 0.4,
            vibrancy_darkness = 0.4,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.1, 0},     {0.0, 1}     } })

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve( "hobbyist",      { type = "spring", mass = 1, stiffness = 40, dampening = 5 } )
hl.curve( "cat",           { type = "spring", mass = 1.4, stiffness = 30, dampening = 6 } )

hl.animation({ leaf = "global",        enabled = true,  speed = 8,    bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 2,    bezier = "almostLinear" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 8,    spring = "cat",        style = "slide" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 8,    spring = "cat",        style = "slide" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 8,    spring = "cat",        style = "slide bottom" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 6,    spring = "hobbyist" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "slide bottom" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 3,    bezier = "linear",       style = "slide bottom" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 8,    spring = "hobbyist",     style = "slidevert" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 8,    spring = "hobbyist",     style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 8,    spring = "hobbyist",     style = "slidevert" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 6,    bezier = "quick" })

hl.config({
  dwindle = {
      force_split                  = 0,
      preserve_split               = false,
      smart_split                  = false,
      smart_resizing               = true,
      permanent_direction_override = false,
      special_scale_factor         = 1,
      split_width_multiplier       = 1.0,
      use_active_for_splits        = true,
      default_split_ratio          = 1.0,
      split_bias                   = 0,
      precise_mouse_move           = false,
  },
})

hl.config({
    master = {
        new_status = "master",
        mfact = 0.50,
        orientation = "right",
        new_on_top = true,
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
        follow_focus = true,
        focus_fit_method = 1,
        follow_min_visible = 0.1,
        wrap_focus = true,
        direction = "right",
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        numlock_by_default = false,
        repeat_rate = 60,
        repeat_delay = 200,
        follow_mouse = 1,
        sensitivity = 1.0,
        scroll_factor = 2.0,
        accel_profile = "adaptive",
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("bash $HOME/.config/Scripts/auto_detect_terminal.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("librewolf"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("bash $HOME/.config/Scripts/rofi_clipboard.sh"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("kdeconnect-app"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e bluetui"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("kitty -e btop"))

hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("Telegram"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("notify-send 'Hyprland doesnt have an overview feature'"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("pkill wlogout || wlogout"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { repeating = true })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill waybar || waybar -c $HOME/.config/waybar/Hyprland/config.jsonc -s $HOME/.config/waybar/style.css"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("brave-origin-beta https://www.youtube.com"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("bash $HOME/.config/Scripts/random_wall_on_home.sh"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("kitty -e cmus"), { repeating = false })
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("kitty -e nmtui"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("localsend"), { repeating = false })

hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd("pkill rofi || rofi -show drun -theme ~/.config/rofi/launchpad.rasi"))
hl.bind(mainMod .. " + Delete", hl.dsp.exec_cmd("cliphist wipe"))
hl.bind(mainMod .. " + Grave",  hl.dsp.layout("swapwithmaster master"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("bash $HOME/.config/Scripts/auto_detect_terminal.sh"))

hl.bind(mainMod .. " + ALT + B",    hl.dsp.exec_cmd("brave-origin-beta"))
hl.bind(mainMod .. " + CTRL + R",   hl.dsp.exec_cmd(" bash ~/.config/Scripts/partial_screenshot.sh"),   { locked = true, repeating = false })
hl.bind(mainMod .. " + CTRL + S",   hl.dsp.exec_cmd(" bash ~/.config/Scripts/full_screenshot.sh"),      { locked = true, repeating = false })
hl.bind(mainMod .. " + CTRL + E",   hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + R",  hl.dsp.exec_cmd(" bash ~/.config/Scripts/screen_recorder.sh"),      { locked = true, repeating = false })

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + H",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",     hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + SHIFT + H",     hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L",     hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K",     hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J",     hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + I",     hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + U",     hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + down",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ workspace = "e-1" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind("ALT + Space",          hl.dsp.workspace.toggle_special("magic"))
hl.bind("ALT + SHIFT + Space",  hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 10%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),        { locked = true, repeating = false })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),      { locked = true, repeating = false })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl set 10%+"),                            { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl set 10%-"),                            { locked = true, repeating = true })

hl.bind("ALT + BracketRight",     hl.dsp.exec_cmd("wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 10%+"), { locked = true, repeating = true })
hl.bind("ALT + BracketLeft",      hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),        { locked = true, repeating = true })
hl.bind("ALT + slash",            hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),        { locked = true, repeating = false })
hl.bind("ALT + backslash",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),      { locked = true, repeating = false })
hl.bind("ALT + apostrophe",       hl.dsp.exec_cmd("brightnessctl set 10%+"),                            { locked = true, repeating = true })
hl.bind("ALT + semicolon",        hl.dsp.exec_cmd("brightnessctl set 10%-"),                            { locked = true, repeating = true })

hl.bind("ALT + Period",   hl.dsp.exec_cmd(" bash ~/.config/Scripts/full_screenshot.sh"),                { locked = true, repeating = false })
hl.bind("ALT + Comma",    hl.dsp.exec_cmd(" bash ~/.config/Scripts/partial_screenshot.sh"),             { locked = true, repeating = false })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("Print",        hl.dsp.exec_cmd("bash ~/.config/Scripts/full_screenshot.sh"),      { locked = true, repeating = false })
hl.bind("ALT + Print",  hl.dsp.exec_cmd("bash ~/.config/Scripts/partial_screenshot.sh"),   { locked = true, repeating = false })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("bash ~/.config/Scripts/screen_recorder.sh"),      { locked = true, repeating = false })

hl.bind("ALT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("ALT + W", hl.dsp.exec_cmd("bash ~/.config/Scripts/wallpaper_switcher.sh"))
hl.bind("ALT + L", hl.dsp.exec_cmd("bash ~/.config/Scripts/random_wall_on_lockscr.sh"),                      { locked = false, repeating = false })
hl.bind("ALT + Z", hl.dsp.exec_cmd("hyprctl reload"),                                                        { locked = true, repeating = false })
hl.bind("ALT + O", hl.dsp.exec_cmd("systemctl poweroff"),                                                    { locked = true, repeating = false })
hl.bind("ALT + R", hl.dsp.exec_cmd("systemctl reboot"),                                                      { locked = true, repeating = false })
hl.bind("ALT + S", hl.dsp.exec_cmd("systemctl suspend ; bash ~/.config/Scripts/random_wall_on_lockscr.sh"),  { locked = true, repeating = false })

hl.bind(mainMod .. "+ period", hl.dsp.layout("move +col"))
hl.bind(mainMod .. "+ comma", hl.dsp.layout("swapcol l"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.workspace_rule({ workspace = "1", layout = "dwindle" })
hl.workspace_rule({ workspace = "2", layout = "scrolling" })

hl.window_rule({
    name   = "float-file-pickers",
    match  = { title = "^(Open File|Open Folder|Open|Save|Save As|Export|Import|Choose File|Rename)$" },
    float  = true,
    center = true,
})

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
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

hl.window_rule({
    name  = "pip n kdeconnect daemon popups",
    match = { title = "Picture-in-Picture|Picture in picture", },
    match = { class = "org.kde.kdeconnect.daemon" },
    float = true,
    move = {1470,820},
    opacity = "1.0",
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
    name  = "Floating apps",
    match = { class = "org.kde.kdeconnect.app|localsend" },
    animation = "slide right",
    float = true,
    no_initial_focus = false,
    move = {1510,300},
    opacity = "0.8",
    pin = true,
    size = {"(monitor_w*0.20)","(monitor_h*0.70)"},
})
