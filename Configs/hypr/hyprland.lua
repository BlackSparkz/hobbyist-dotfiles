------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1.0",
})

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
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


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 4,

        col = {
            -- active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            active_border   = "rgba(ffffffff)",
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "scrolling",
    },

    decoration = {
        rounding       = 24,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
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

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.1, 0},     {0.0, 1}     } })

-- Default springs
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

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
        mfact = 0.50,
        orientation = "right",
        new_on_top = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
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
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
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

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("alacritty"))
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

hl.bind(mainMod .. " + ALT + B",    hl.dsp.exec_cmd("brave-origin-beta"))
hl.bind(mainMod .. " + CTRL + R",   hl.dsp.exec_cmd(" bash ~/.config/Scripts/partial_screenshot.sh"),   { locked = true, repeating = false })
hl.bind(mainMod .. " + CTRL + S",   hl.dsp.exec_cmd(" bash ~/.config/Scripts/full_screenshot.sh"),      { locked = true, repeating = false })
hl.bind(mainMod .. " + CTRL + E",   hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + R",  hl.dsp.exec_cmd(" bash ~/.config/Scripts/screen_recorder.sh"),      { locked = true, repeating = false })

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
-- hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
-- hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",     hl.dsp.focus({ direction = "down" }))

-- Move windows
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

-- -- Resize windows (hold mainMod + Ctrl)
-- hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ direction = "l", step = 50 }))
-- hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ direction = "r", step = 50 }))
-- hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ direction = "u", step = 50 }))
-- hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ direction = "d", step = 50 }))
--
-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind("ALT + Space",          hl.dsp.workspace.toggle_special("magic"))
hl.bind("ALT + SHIFT + Space",  hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
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

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- hl.bind("XF86Lock",       hl.dsp.exec_cmd(" bash ~/.config/Scripts/random_wall_on_lockscr.sh"),         { repeating = false })

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

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
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
    name  = "pip-for-firefox-based",
    match = { title = "Picture-in-Picture", },
    float = true,
    move = {1420,790},
    opacity = "1.0",
    keep_aspect_ratio = true,
    size = {"(monitor_w*0.25)", "(monitor_h*0.25)"},
    no_initial_focus = true,
})

hl.window_rule({
    name  = "pip-for-chromium-based",
    match = { title = "Picture in picture",},
    float = true,
    move = {1420,780},
    opacity = "1.0",
    keep_aspect_ratio = true,
    size = {"(monitor_w*0.24)", "(monitor_h*0.24)"},
    no_initial_focus = true,
})

hl.layer_rule({
    name  = "wlogout",
    match = { namespace = "logout_dialog" },
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
    name  = "rofi",
    match = { namespace = "rofi" },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    name  = "quickshell",
    match = { namespace = "quickshell" },
    blur = true,
    ignore_alpha = 0,
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

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "localsend",
    match = { class = "localsend" },
    animation = "slide right",
    float = true,
    no_initial_focus = false,
    move = {1505,300},
    opacity = "0.8",
    pin = true,
    size = {"(monitor_w*0.20)", "(monitor_h*0.70)"},
})

hl.window_rule({
    name  = "kdeconnect",
    match = { class = "org.kde.kdeconnect.app" },
    animation = "slide right",
    float = true,
    no_initial_focus = false,
    move = {1510,300},
    opacity = "0.8",
    pin = true,
    size = {"(monitor_w*0.20)", "(monitor_h*0.70)"},
})

hl.window_rule({
    name  = "kdeconnect daemon",
    match = { class = "org.kde.kdeconnect.daemon" },
    animation = "slide right",
    float = true,
    size = {"(monitor_w*0.24)", "(monitor_h*0.24)"},
    no_initial_focus = false,
    move = {1430,790},
    opacity = "0.8",
    pin = true,
})
