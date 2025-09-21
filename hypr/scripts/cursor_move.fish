#!/usr/bin/fish

# Script para mover cursor entre monitores no Hyprland
set current_monitor (hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
set all_monitors (hyprctl monitors -j | jq -r '.[].name')
set target_monitor ""

for monitor in $all_monitors
    if test "$monitor" != "$current_monitor"
        set target_monitor $monitor
        break
    end
end

if test -n "$target_monitor"
    set monitor_info (hyprctl monitors -j | jq -r ".[] | select(.name == \"$target_monitor\")")
    set width (echo $monitor_info | jq -r '.width')
    set height (echo $monitor_info | jq -r '.height')
    set x (echo $monitor_info | jq -r '.x')
    set y (echo $monitor_info | jq -r '.y')
    
    # Calcular centro do monitor alvo
    set center_x (math "$x + $width / 2")
    set center_y (math "$y + $height / 2")
    
    # Mover cursor para o centro do outro monitor
    hyprctl cursorpos $center_x $center_y
    echo "Cursor movido para $target_monitor"
else
    echo "Não foi encontrado outro monitor"
end