#!/bin/bash
# Script de monitoreo: Ejecutado UNICA VEZ por Waybar.

# Monitorear eventos (mmsg -w) y procesar el output línea por línea.
mmsg -w | while IFS= read -r line; do
    
    # 1. Sólo procesar la línea si contiene la palabra clave 'title'
    if echo "$line" | grep -q "title "; then
        
        # 2. Extracción y Limpieza Robusta (sin depender de caracteres especiales como '·'):
        #    a. Extrae después de 'title '.
        #    b. Elimina comillas y saltos de línea (tr -d).
        #    c. Limita la longitud a 50 caracteres (cut -c 1-50).
        #    d. Limpia espacios sobrantes (xargs).
        ACTIVE_TITLE=$(echo "$line" | sed 's/^.*title //g' | tr -d '\n"' | tr -d "'" | cut -c 1-50 | xargs)
        
        # 3. Filtro Final y Salida JSON para Waybar
        # Filtra títulos vacíos y evita mostrar el nombre del script.
        if [ -z "$ACTIVE_TITLE" ] || [[ "$ACTIVE_TITLE" == *title-app.sh* ]] || [[ "$ACTIVE_TITLE" == *mango-title.sh* ]]; then
            echo "{\"text\": \"Mango Desktop\"}"
        else
            # Muestra el icono y el título dinámico
            echo "{\"text\": \"󰇘 $ACTIVE_TITLE\"}"
        fi
    fi
done
