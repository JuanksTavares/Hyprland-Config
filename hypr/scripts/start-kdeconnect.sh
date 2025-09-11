#!/bin/bash
# ~/.config/hypr/scripts/start-kdeconnect.sh

# Esperar um pouco após o login
sleep 5

# Verificar se o kdeconnect já está rodando
if ! pgrep -x "kdeconnect-indicator" > /dev/null; then
    kdeconnect-indicator &
    sleep 2
fi

# Verificar conexão
if kdeconnect-cli --list-available | grep -q "paired"; then
    notify-send "KDE Connect" "Conectado com sucesso!"
else
    notify-send "KDE Connect" "Aguardando conexão..."
fi