#!/usr/bin/env bash
set +e # disable immediate exit on error

# Close the panel to prevent any interference
swaync-client -cp

if [[ $SWAYNC_TOGGLE_STATE == true ]]; then
  {
    sed -i 's/-m "light"/-m "dark"/' ~/.config/waypaper/config.ini
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    yes | fish -c 'fish_config theme save "TokyoNight Moon"'
  } >/dev/null 2>&1 || :
else
  {
    sed -i 's/-m "dark"/-m "light"/' ~/.config/waypaper/config.ini
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    yes | fish -c 'fish_config theme save "TokyoNight Day"'
  } >/dev/null 2>&1 || :
fi
{ setsid -f waypaper --restore; } >/dev/null 2>&1 || :

exit 0
