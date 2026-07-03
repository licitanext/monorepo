#!/bin/bash
# Construye la imagen de hunter-core y la carga en minikube.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SERVICE_DIR="$PROJECT_ROOT/services/hunter-core"
BUILD_ID="$(date +%Y%m%d-%H%M%S)"
IMAGE_TAG="localhost/licitanext-hunter-core:${BUILD_ID}"
IMAGE_TAG_DEV="localhost/licitanext-hunter-core:dev"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Motor de contenedores: podman por defecto, docker como fallback.
ENGINE="${CONTAINER_ENGINE:-podman}"
if ! command -v "$ENGINE" >/dev/null 2>&1; then
	if command -v docker >/dev/null 2>&1; then
		ENGINE="docker"
	else
		echo -e "${RED}❌ Ni podman ni docker disponibles.${NC}"
		exit 1
	fi
fi

if ! command -v minikube >/dev/null 2>&1; then
	echo -e "${RED}❌ minikube no está instalado.${NC}"
	exit 1
fi

if ! minikube status >/dev/null 2>&1; then
	echo -e "${RED}❌ minikube no está corriendo. Arráncalo primero (make dev-minikube-deploy).${NC}"
	exit 1
fi

if [ ! -d "$SERVICE_DIR" ]; then
	echo -e "${RED}❌ No existe el servicio: $SERVICE_DIR${NC}"
	exit 1
fi

echo -e "${BLUE}🐳 Construyendo imagen ($ENGINE): ${IMAGE_TAG}${NC}"
"$ENGINE" build -t "${IMAGE_TAG}" -f "$SERVICE_DIR/Dockerfile" "$SERVICE_DIR"
"$ENGINE" tag "${IMAGE_TAG}" "${IMAGE_TAG_DEV}"

echo -e "${BLUE}📦 Cargando imagen en minikube...${NC}"
"$ENGINE" save "${IMAGE_TAG_DEV}" | minikube image load -

echo -e "${GREEN}✅ Imagen construida (${BUILD_ID}) y cargada como ${IMAGE_TAG_DEV}${NC}"
