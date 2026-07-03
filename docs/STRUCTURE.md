# Estructura del Monorepo — LicitaNext

Estructura alineada con el patrón del boilerplate
`lapc506/flutter-agentic-boilerplate` (Clean Architecture + Atomic Design en la
app, Agent Skills, IaC), con las desviaciones propias de LicitaNext anotadas
abajo.

## Árbol de directorios

```
monorepo/
├── AGENTS.md                     # Agent Skills + taxonomía Linear
├── README.md                     # Guía de inicio
├── mcp.json                      # Configuración de MCP servers
├── Makefile                      # Automatización (env-recurso-verbo)
│
├── apps/
│   └── mobile/                   # App Flutter (org cr.licitanext)
│       ├── lib/
│       │   ├── core/             # Constantes, errores, red, tema, utils
│       │   ├── features/         # Módulos por feature (Clean Architecture)
│       │   │   └── [feature]/{data,domain,presentation}/
│       │   ├── shared/ui/        # Atomic Design
│       │   │   ├── atoms/  molecules/  organisms/  templates/
│       │   └── main.dart
│       └── test/
│
├── services/                     # ⚠️ Desviación: backend Python agéntico
│   └── hunter-core/              # FastAPI: ingesta SICOP + match UNSPSC
│       ├── src/hunter_core/
│       ├── tests/
│       └── docs/ARCHITECTURE.md
│
├── libs/                         # Paquetes Dart/Python compartidos entre apps
├── skills/                       # Agent Skills (flutter/, backend/, cicd/)
├── specs/                        # Especificaciones de requisitos (IEEE 830)
├── scripts/                      # Scripts de utilidad (admin, setup, validación)
├── linear-todo-templates/        # Templates de issues de Linear
│
├── infrastructure/
│   ├── terraform/{environments,modules}/
│   ├── helm-charts/  docker/  kms/
│   └── scripts/                  # start-minikube.sh, build-hunter-image-minikube.sh
│
├── k8s/                          # Manifiestos K8s de aplicación
│   ├── base/hunter-core/
│   └── overlays/dev/             # namespace licitanext-dev
│
└── docs/
    ├── content/{docs,assets}/    # Documentación principal (MkDocs/Docusaurus)
    ├── templates/                # Plantillas (IEEE 830, ADR, etc.)
    ├── versioning/  monitoring/  security/
    ├── sicop/                    # Datos abiertos, diccionario y ERD de SICOP
    └── firma-digital-gaudi.md    # Integración de firma digital (Gaudí)
```

## Desviaciones respecto al boilerplate (y por qué)

| Boilerplate | LicitaNext | Motivo |
|-------------|------------|--------|
| `apps/backend/` (NestJS/Express) | `services/hunter-core/` (Python/FastAPI) | El backend de LicitaNext es un pipeline agéntico Python (patrón `agentic-core`), no una API REST NestJS. |
| `apps/widgetbook/` | — (pendiente) | Aún no hay componentes UI compartidos que catalogar. Se añadirá cuando `shared/ui/` tenga contenido. |
| overlays `qa/staging/prod` + `k8s/argocd/` | solo `overlays/dev/` | La infra productiva (OVH) aún no está definida; se evita crear overlays vacíos que rompan `kustomize`. Los targets qa/stage/prod del Makefile son stubs. |
| 54 skills incluidos | scaffold + referencia | Los skills genéricos se referencian desde el boilerplate en vez de duplicarlos; aquí solo van los específicos de LicitaNext. |

## Arquitectura de la app móvil

`apps/mobile/lib/` sigue **Clean Architecture** por feature (capas
`domain/` ← `data/` y `domain/` ← `presentation/`, dependencias
unidireccionales) y **Atomic Design** para la UI compartida en `shared/ui/`
(`atoms` → `molecules` → `organisms` → `templates`). State management
recomendado: **Riverpod** (o **Air Framework** para escala enterprise).
