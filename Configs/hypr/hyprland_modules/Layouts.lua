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
