#!/bin/bash

cliphist list | fzf \
  --prompt=" Search clipboard: " \
  --reverse \
  --border \
  --header ' Enter: Copy | Ctrl+D: Delete | Ctrl+A: Clear all | Esc: Quit' \
  --bind 'ctrl-d:execute(echo {} | cliphist delete)+reload(cliphist list)' \
  --bind 'ctrl-a:execute(cliphist wipe)+reload(cliphist list)' \
  | cliphist decode | wl-copy
