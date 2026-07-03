# LicitaNext Monorepo - Automation Makefile
# ==========================================
#
# Convención de nombres: env-recurso-verbo
# Ejemplos:
#   make dev-minikube-deploy     # Crea el cluster minikube
#   make dev-hunter-deploy       # Despliega hunter-core en dev
#   make dev-mobile-launch-web   # Lanza la app Flutter en el navegador
#
# Uso:
#   make <target>

.PHONY: help setup \
        dev-minikube-deploy dev-minikube-destroy dev-minikube-clear \
        dev-images-build \
        dev-hunter-deploy dev-hunter-destroy dev-hunter-logs \
        dev-mobile-launch-desktop dev-mobile-launch-web \
        dev-mobile-analyze dev-mobile-test \
        dev-terraform-deploy dev-terraform-destroy \
        dev-argocd-deploy \
        qa-deploy stage-deploy prod-deploy

# ==========================================
# Variables
# ==========================================

SCRIPTS_DIR   = infrastructure/scripts
MOBILE_DIR    = apps/mobile
HUNTER_DIR    = services/hunter-core
K8S_OVERLAY   = k8s/overlays/dev
NAMESPACE     = licitanext-dev

BLUE   := \033[36m
GREEN  := \033[32m
YELLOW := \033[33m
RED    := \033[31m
NC     := \033[0m

# ==========================================
# Ayuda (target por defecto)
# ==========================================

.DEFAULT_GOAL := help

help: ## Muestra esta ayuda
	@echo ""
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║   LicitaNext Monorepo - Comandos (env-recurso-verbo)           ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(GREEN)Quick Start (dev):$(NC)"
	@echo "  make setup"
	@echo "  make dev-minikube-deploy && make dev-images-build && make dev-hunter-deploy"
	@echo ""
	@echo "$(GREEN)Setup:$(NC)"
	@echo "  $(YELLOW)setup$(NC)                       Instala deps del servicio y prepara la app Flutter"
	@echo ""
	@echo "$(GREEN)DEV - Minikube:$(NC)"
	@echo "  $(YELLOW)dev-minikube-deploy$(NC)         Arranca el cluster minikube"
	@echo "  $(YELLOW)dev-minikube-clear$(NC)          Limpia namespaces atascados (finalizers)"
	@echo "  $(YELLOW)dev-minikube-destroy$(NC)        Elimina el cluster minikube"
	@echo ""
	@echo "$(GREEN)DEV - Imágenes:$(NC)"
	@echo "  $(YELLOW)dev-images-build$(NC)            Construye hunter-core y la carga en minikube"
	@echo ""
	@echo "$(GREEN)DEV - hunter-core:$(NC)"
	@echo "  $(YELLOW)dev-hunter-deploy$(NC)           Despliega hunter-core (kubectl apply -k)"
	@echo "  $(YELLOW)dev-hunter-destroy$(NC)          Elimina hunter-core del cluster"
	@echo "  $(YELLOW)dev-hunter-logs$(NC)             Muestra los logs de hunter-core"
	@echo ""
	@echo "$(GREEN)DEV - App móvil (Flutter):$(NC)"
	@echo "  $(YELLOW)dev-mobile-launch-desktop$(NC)   Lanza la app en Linux desktop"
	@echo "  $(YELLOW)dev-mobile-launch-web$(NC)       Lanza la app en el navegador (Chrome)"
	@echo "  $(YELLOW)dev-mobile-analyze$(NC)          flutter analyze"
	@echo "  $(YELLOW)dev-mobile-test$(NC)             flutter test"
	@echo ""
	@echo "$(GREEN)Otros entornos (stubs):$(NC)"
	@echo "  $(YELLOW)dev-terraform-deploy$(NC)  $(YELLOW)dev-argocd-deploy$(NC)"
	@echo "  $(YELLOW)qa-deploy$(NC)  $(YELLOW)stage-deploy$(NC)  $(YELLOW)prod-deploy$(NC)"
	@echo ""

# ==========================================
# Setup
# ==========================================

setup: ## Instala deps del servicio y prepara la app Flutter
	@echo "$(BLUE)📦 Preparando hunter-core...$(NC)"
	@cd $(HUNTER_DIR) && (command -v uv >/dev/null 2>&1 && uv venv .venv && uv pip install -e '.[dev]' || (python3 -m venv .venv && ./.venv/bin/pip install -e '.[dev]'))
	@echo "$(BLUE)📱 Preparando app Flutter...$(NC)"
	@cd $(MOBILE_DIR) && flutter pub get
	@echo "$(GREEN)✅ Setup completo$(NC)"

# ==========================================
# DEV - Minikube
# ==========================================

dev-minikube-deploy: ## Arranca el cluster minikube
	@$(SCRIPTS_DIR)/start-minikube.sh

dev-minikube-clear: ## Limpia namespaces atascados por finalizers
	@echo "$(YELLOW)🧹 Limpiando finalizers del namespace $(NAMESPACE)...$(NC)"
	@kubectl get namespace $(NAMESPACE) -o json 2>/dev/null | \
		sed 's/"kubernetes"//' | \
		kubectl replace --raw "/api/v1/namespaces/$(NAMESPACE)/finalize" -f - 2>/dev/null || \
		echo "$(BLUE)Nada que limpiar$(NC)"

dev-minikube-destroy: ## Elimina el cluster minikube
	@echo "$(RED)💥 Eliminando cluster minikube...$(NC)"
	@minikube delete

# ==========================================
# DEV - Imágenes
# ==========================================

dev-images-build: ## Construye hunter-core y la carga en minikube
	@$(SCRIPTS_DIR)/build-hunter-image-minikube.sh

# ==========================================
# DEV - hunter-core
# ==========================================

dev-hunter-deploy: ## Despliega hunter-core en dev (kubectl apply -k)
	@echo "$(BLUE)🚀 Desplegando hunter-core en $(NAMESPACE)...$(NC)"
	@kubectl apply -k $(K8S_OVERLAY)
	@echo "$(GREEN)✅ hunter-core desplegado$(NC)"

dev-hunter-destroy: ## Elimina hunter-core del cluster
	@echo "$(RED)💥 Eliminando hunter-core...$(NC)"
	@kubectl delete -k $(K8S_OVERLAY) --ignore-not-found

dev-hunter-logs: ## Muestra los logs de hunter-core
	@kubectl logs -n $(NAMESPACE) -l app=hunter-core --tail=100 -f

# ==========================================
# DEV - App móvil (Flutter)
# ==========================================

dev-mobile-launch-desktop: ## Lanza la app Flutter en Linux desktop
	@cd $(MOBILE_DIR) && ./launch_flutter_debug.sh -l

dev-mobile-launch-web: ## Lanza la app Flutter en el navegador (Chrome)
	@cd $(MOBILE_DIR) && ./launch_flutter_debug.sh -w

dev-mobile-analyze: ## flutter analyze
	@cd $(MOBILE_DIR) && flutter analyze

dev-mobile-test: ## flutter test
	@cd $(MOBILE_DIR) && flutter test

# ==========================================
# Stubs (infra aún no provisionada)
# ==========================================

dev-terraform-deploy: ## TODO: provisionar infra dev con Terraform
	@echo "$(YELLOW)TODO: dev-terraform-deploy (infra OVH aún no definida)$(NC)"

dev-terraform-destroy: ## TODO
	@echo "$(YELLOW)TODO: dev-terraform-destroy$(NC)"

dev-argocd-deploy: ## TODO: GitOps con ArgoCD
	@echo "$(YELLOW)TODO: dev-argocd-deploy$(NC)"

qa-deploy: ## TODO
	@echo "$(YELLOW)TODO: qa-deploy$(NC)"

stage-deploy: ## TODO
	@echo "$(YELLOW)TODO: stage-deploy$(NC)"

prod-deploy: ## TODO
	@echo "$(YELLOW)TODO: prod-deploy$(NC)"
