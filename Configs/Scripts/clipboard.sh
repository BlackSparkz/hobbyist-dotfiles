#!/bin/bash

cliphist list | fzf \
  --prompt="Search clipboard: " \
  --reverse \
  --border \
  --header 'Enter: Copy | Ctrl+D: Delete | Ctrl+A: Clear all | Ctrl+Q: QR | Esc: Quit' \
  --bind 'ctrl-d:execute(echo {} | cliphist delete)+reload(cliphist list)' \
  --bind 'ctrl-a:execute(cliphist wipe)+reload(cliphist list)' \
  --bind 'ctrl-q:execute-silent(cliphist decode {} | qrencode -o /tmp/clip-qr.png -s 10 -m 2 -t PNG && timeout 10 swayimg /tmp/clip-qr.png)' \
  | cliphist decode | wl-copy
