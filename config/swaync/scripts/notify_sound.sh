#!/usr/bin/env bash
# Plays a short sound for every notification.
# Tries paplay (PulseAudio/PipeWire), falls back to canberra.

set +e # disable immediate exit on error

if [[ "$SWAYNC_HINT_SUPPRESS_SOUND" == "true" ]]; then
  exit 0
fi

SOUND="${HOME}/.config/swaync/sounds/Chord.wav"

if [[ "$(swaync-client --get-dnd)" == "false" ]]; then
  if command -v paplay >/dev/null 2>&1 && [ -f "$SOUND" ]; then
    { paplay "$SOUND"; } >/dev/null 2>&1 || :
  elif command -v canberra-gtk-play >/dev/null 2>&1; then
    # built-in theme sound as a fallback
    { canberra-gtk-play -i message; } >/dev/null 2>&1 || :
  fi
fi

exit 0
