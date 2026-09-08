function yt
    set query (string join ' ' $argv)

    yt-dlp "ytsearch20:$query" \
        --flat-playlist \
        --print "%(id)s|%(title)s" |
        fzf --delimiter='|' --with-nth=2.. |
        cut -d'|' -f1 |
        xargs -r -I{} mpv --ytdl-format="bestvideo[height<=720]+bestaudio/best[height<=720]" "https://www.youtube.com/watch?v={}"
end
