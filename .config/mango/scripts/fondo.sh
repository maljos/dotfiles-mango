#!/bin/bash

# Ruta al archivo de configuración de Nitrogen
NITROGEN_CONFIG="$HOME/.config/nitrogen/bg-saved.cfg"

# Herramienta de Wayland para fondos de pantalla
WALLPAPER_TOOL="swaybg"
WALLPAPER_MODE="fill" # Modo: fill, fit, stretch, etc.

# 1. Extraer la ruta del archivo de la configuración
# Busca la línea que comienza con "file=" y extrae el valor
WALLPAPER_PATH=$(grep '^file=' "$NITROGEN_CONFIG" | cut -d'=' -f2)

# Verificar si se encontró la ruta
if [ -z "$WALLPAPER_PATH" ]; then
    echo "Error: No se encontró la ruta del fondo de pantalla en $NITROGEN_CONFIG"
    exit 1
fi

# 2. Ejecutar la herramienta de Wayland con la ruta extraída
# El "&" al final es importante para que el script no bloquee el inicio de Wayland.
exec $WALLPAPER_TOOL -i "$WALLPAPER_PATH" -m "$WALLPAPER_MODE" >/dev/null 2>&1 &
