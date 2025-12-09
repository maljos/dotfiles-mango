#!/bin/bash
case "$1" in click) mmsg -t "$2" ;; esac
mmsg -g -t \
| awk '
BEGIN {
    printf "["
    first = 1
}
/^HDMI-A-1 tag [0-9]/ {
    if (!first) {
        printf ","
    }
    name=$3; occ=$4; sel=$5;
    class=(sel ? "focused" : "visible");

    # Nota: Waybar espera que la clase se llame "active" o "occupied"
    # El uso de "focused" o "visible" es CSS, no el estado real.
    # Usaremos 'active' si es 'sel' (seleccionado).
    active_class = (sel ? "active" : "visible");

    printf "{\"text\":\"%s\",\"class\":\"%s\",\"name\":\"%s\"}", name, active_class, name
    first = 0
}
END {
    printf "]\n"
}'
