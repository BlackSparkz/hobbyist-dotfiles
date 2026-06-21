----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo   = true,
    animate_manual_resizes = true,
    animate_mouse_windowdragging = true,
    mouse_move_enables_dpms = false,
    key_press_enables_dpms = true,
    initial_workspace_tracking = 0,
    enable_swallow = true,
    swallow_regex = "(kitty|Alacritty|foot|ghostty)",
    middle_click_paste = true,
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },

})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
