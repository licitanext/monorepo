# Agentes y Skills — LicitaNext

Este monorepo sigue el patrón de **Agent Skills** del boilerplate de
referencia (`flutter-agentic-boilerplate`): carpetas con `SKILL.md` que dan
conocimiento contextual y capacidades especializadas a los asistentes de IA,
con carga progresiva para eficiencia de tokens.

Este documento es la fuente de verdad de dos cosas: (1) dónde viven los skills
y (2) la taxonomía obligatoria de labels de Linear.

## Skills

Los skills viven en [`skills/`](skills/), organizados por dominio:

```
skills/
├── flutter/    # Skills de desarrollo Flutter (app cazadora de licitaciones)
├── backend/    # Skills del pipeline Python (hunter-core: ingesta SICOP, UNSPSC)
└── cicd/       # Skills de infraestructura y despliegue (Minikube, KNative, OVH)
```

El catálogo completo de skills reutilizables (Flutter, CI/CD, SRE, Figma,
static-analysis) se mantiene en el boilerplate
`lapc506/flutter-agentic-boilerplate`. Aquí sólo se versionan los skills
específicos de LicitaNext; los genéricos se referencian desde ese repo en vez
de duplicarlos.

### Invocación

```
@skill:backend/sicop-ingesta   - Implementa un adaptador de datos abiertos
@skill:flutter/clean-architecture - Estructura un feature nuevo de la app
```

## Linear MCP — Taxonomía obligatoria de labels

Al crear o etiquetar issues en Linear vía MCP, usar siempre esta taxonomía.

### Grupos exclusivos (solo uno por grupo)

**Type** (requerido): `Bug`, `Chore`, `Feature`, `Spike`, `Improvement`, `Design`.

**Size** (requerido, mapea a presupuesto de tokens):
`XS` (<50K), `S` (50-100K), `M` (100-200K), `L` (200-500K), `XL` (500K+, descomponer).

**Strategy** (opcional): `Solo`, `Explore`, `Team`, `Human`, `Worktree`, `Review`.

### Labels combinables

**Component:** Frontend, Backend, Database, Security, Performance, Infra, Testing.
**Impact:** Critical Path, Revenue, Grant.
**Flags:** Blocked, Quick Win, Epic.

### Reglas

1. Siempre asignar al menos **Type + Size** al crear un issue.
2. **XL = descomponer** — nunca un XL sin sub-issues.
3. **Strategy determina la ejecución** — Solo→agente individual, Team→Agent Teams, Human→esperar decisión.
4. **Component es combinable** (p. ej. Backend + Database + Testing).
5. Verificar labels existentes con `list_issue_labels` antes de crear duplicados.
6. Mapear al proyecto Linear correcto (Mobile App, hunter-core, Infra, etc.).

## MCP Servers

Configurados en [`mcp.json`](mcp.json). Ver taxonomía de Linear arriba antes de
interactuar con el MCP de Linear.
