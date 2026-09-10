function clean
    set orphans (pacman -Qdtq)

    if test (count $orphans) -gt 0
        echo "Removing orphan packages..."
        sudo pacman -Rns --noconfirm $orphans
    else
        echo "No orphan packages"
    end

    echo "Cleaning AUR dependencies..."
    yay -Yc --noconfirm

    echo "Cleaning package cache..."
    sudo rm -rf /var/cache/pacman/pkg/download-*/

    echo "Removing yay cache..."
    rm -rf ~/.cache/yay

    echo "Cleaning logs..."
    sudo journalctl --vacuum-time=7d

    echo "Cleanup done"
    notify-send "Cleanup done" "The system is now bloat-free"
end
