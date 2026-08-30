#!/usr/bin/env fish

function swapcaps
    set current (gsettings get org.gnome.desktop.input-sources xkb-options)

    if string match -q "*caps:swapescape*" -- $current
        gsettings set org.gnome.desktop.input-sources xkb-options "[]"
        echo "🖥️ Caps-Escape Swap: OFF"
    else
        gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
        echo "💻 Caps-Escape Swap: ON"
    end
end
        
