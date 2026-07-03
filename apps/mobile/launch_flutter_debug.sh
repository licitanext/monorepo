#!/bin/bash

# ==============================================================================
# LicitaNext - Script de lanzamiento en debug (Linux Desktop + Web)
# ==============================================================================
#
# Uso:
#   ./launch_flutter_debug.sh            # menú interactivo
#   ./launch_flutter_debug.sh -l         # Linux desktop
#   ./launch_flutter_debug.sh -w         # Web (Chrome)
#   ./launch_flutter_debug.sh -h         # Ayuda
# ==============================================================================

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

# Añade el SDK de Flutter al PATH si está en la ruta habitual del dev.
if ! command -v flutter >/dev/null 2>&1; then
	if [ -x "$HOME/flutter/bin/flutter" ]; then
		export PATH="$PATH:$HOME/flutter/bin"
	fi
fi

if ! command -v flutter >/dev/null 2>&1; then
	echo -e "${RED}❌ flutter no está en el PATH. Instálalo o añade \$HOME/flutter/bin.${NC}"
	exit 1
fi

usage() {
	echo -e "${BLUE}LicitaNext - lanzador debug${NC}"
	echo "  -l    Linux desktop"
	echo "  -w    Web (Chrome)"
	echo "  -h    Ayuda"
}

launch_linux() {
	echo -e "${GREEN}🖥️  Lanzando en Linux desktop...${NC}"
	flutter run -d linux
}

launch_web() {
	echo -e "${GREEN}🌐 Lanzando en Web (Chrome)...${NC}"
	flutter run -d chrome
}

TARGET=""
while getopts "lwh" opt; do
	case "$opt" in
		l) TARGET="linux" ;;
		w) TARGET="web" ;;
		h) usage; exit 0 ;;
		*) usage; exit 1 ;;
	esac
done

if [ -z "$TARGET" ]; then
	echo -e "${BLUE}¿Dónde quieres lanzar LicitaNext?${NC}"
	echo "  1) Linux desktop  (-l)"
	echo "  2) Web / Chrome   (-w)"
	read -rp "Opción [1/2]: " choice
	case "$choice" in
		1) TARGET="linux" ;;
		2) TARGET="web" ;;
		*) echo -e "${ORANGE}Opción no válida${NC}"; exit 1 ;;
	esac
fi

case "$TARGET" in
	linux) launch_linux ;;
	web) launch_web ;;
esac
