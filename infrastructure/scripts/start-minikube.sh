#!/bin/bash
# Arranca Minikube para LicitaNext (driver podman por defecto, docker como fallback).

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DRIVER="${MINIKUBE_DRIVER:-podman}"
CPUS="${MINIKUBE_CPUS:-4}"
MEMORY="${MINIKUBE_MEMORY:-8192}"
DISK="${MINIKUBE_DISK:-40g}"

if ! command -v minikube >/dev/null 2>&1; then
	echo -e "${RED}❌ minikube no está instalado.${NC}"
	echo "   Instálalo: https://minikube.sigs.k8s.io/docs/start/"
	exit 1
fi

# Verifica que el driver elegido exista; si no, prueba con docker.
if ! command -v "$DRIVER" >/dev/null 2>&1; then
	echo -e "${RED}⚠️  '$DRIVER' no encontrado.${NC}"
	if command -v docker >/dev/null 2>&1; then
		echo -e "${BLUE}➡️  Usando driver 'docker' como fallback.${NC}"
		DRIVER="docker"
	else
		echo -e "${RED}❌ Ni podman ni docker disponibles.${NC}"
		exit 1
	fi
fi

if minikube status >/dev/null 2>&1; then
	echo -e "${GREEN}✅ Minikube ya está corriendo.${NC}"
	exit 0
fi

echo -e "${BLUE}🚀 Arrancando minikube (driver=$DRIVER, cpus=$CPUS, mem=$MEMORY)...${NC}"
minikube start --driver="$DRIVER" --cpus="$CPUS" --memory="$MEMORY" --disk-size="$DISK"
minikube config set WantUpdateNotification false >/dev/null 2>&1 || true

echo -e "${GREEN}✅ Minikube listo.${NC}"
