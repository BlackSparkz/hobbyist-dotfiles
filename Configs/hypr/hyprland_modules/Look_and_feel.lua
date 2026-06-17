-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 2,

        col = {
            active_border   = "rgba(ffffffff)",
            inactive_border = "rgba(00000000)",
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "master",

        snap = {
            enabled = true,
            respect_gaps = false
        }
    },

    decoration = {
        rounding       = 32,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1,

        dim_special = 0.5,

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
            popups = false,
            popups_ignorealpha = 0,
            noise = 0.02,
            contrast = 1.6,
            brightness = 0.9,
            vibrancy  = 0.4,
            vibrancy_darkness = 0.4,
            special = false
        },
    },

    animations = {
        enabled = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.1, 0},     {0.0, 1}     } })

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve("hobbyist",       { type = "spring", mass = 1, stiffness = 40, dampening = 6 } )
hl.curve("cat",            { type = "spring", mass = 1, stiffness = 30, dampening = 6 } )

hl.animation({ leaf = "global",        enabled = true,  speed = 8,    bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 1,    bezier = "almostLinear" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 10,   spring = "cat",        style = "slide" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 10,   spring = "cat",        style = "slide" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 10,   spring = "cat",        style = "slide bottom" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 10,   spring = "hobbyist" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "slide bottom" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 3,    bezier = "linear",       style = "slide bottom" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 12,   spring = "hobbyist",     style = "slidevert" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 12,   spring = "hobbyist",     style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 12,   spring = "hobbyist",     style = "slidevert" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 8,    bezier = "quick" })

hl.config({
  dwindle = {
      force_split                  = 0,
      preserve_split               = true,
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
