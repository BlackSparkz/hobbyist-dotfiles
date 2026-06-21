------------------
---- GESTURES ----
------------------

hl.config({
  gestures = {
    workspace_swipe_create_new = true,
    workspace_swipe_forever = false,
    workspace_swipe_direction_lock = false,
    close_max_timeout = 100
  }
})

hl.gesture({
  fingers = 4,
  direction = "vertical",
  action = "workspace"
})

for _, dir in ipairs({"left", "right", "up", "down"}) do
  hl.gesture({
    fingers = 3,
    direction = dir,
    action = function()
      hl.dispatch(hl.dsp.focus({direction = dir}))
    end
  })
end

hl.gesture({
  fingers = 4,
  direction = "pinch",
  action = "fullscreen",
  -- mode = "maximize",
})

hl.gesture({
  fingers = 3,
  direction = "pinch",
  action = "close",
})

hl.gesture({
  fingers = 3,
  mods = "SUPER",
  direction = "pinch",
  action = "float",
})

hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})
