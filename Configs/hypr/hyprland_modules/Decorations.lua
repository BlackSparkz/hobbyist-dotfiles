hl.config({
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
})
