# LicitaNext — Monorepo

Agente cazador de licitaciones (copiloto SICOP, Costa Rica). Flutter desktop+web (`apps/mobile`) + `services/hunter-core` (FastAPI, patrón agentic-core) + k8s/Minikube (KNative después).

## 🎯 Directiva SRD (fuente: `../business-model/srd/claude-directive.yml`)

**North Star**: ¿Puede Mariana (P01) ir de conectar su catálogo a UNA OFERTA VÁLIDA PRESENTADA en ≤90 días, sin exclusión formal, pagando en el camino? — **Respuesta actual: No.** Checkpoint: Go/No-Go **2026-10-31**.

### Reglas de prioridad (resumen — el YAML manda)

1. **T0 primero**: nada que no sea J3 (pipeline+match), J8 (autopsias), J9 (checkout) o J1-manual se construye antes del primer slot vendido.
2. **Toda recomendación al usuario cita su fuente** (cartel, Ley 9986, dato histórico) — sin excepciones.
3. Matching validado retrospectivamente (≥70% precision vs corpus 202606) ANTES de alertar a clientes reales.
4. **Recepción ≠ apertura**: distinguirlas en todo código, UI y alerta.
5. P02-proofing: la UX nunca asume vocabulario dev ni requiere GitHub (fallback manual siempre).
6. Dogfooding manda: toda feature pasa por los 4 design partners antes que por un cliente pago.
7. Las fechas del experimento no se mueven; el scope sí.

### Anti-patrones (nunca)

- Prometer presentación 100% automática en SICOP o "ganá licitaciones automáticamente" (Ley 9986 + componenteFirmaCR sin API).
- Construir la app Flutter completa antes del pipeline.
- Usar datos de un cliente para beneficiar a otro.
- Scope creep hacia el lado comprador (instituciones).
- Wishful pricing (la escalera VW y la elección A/B/C deciden).
- Secretos en archivos commiteados (usar entorno o `mcp.local.json`).

### Contexto clave

- Business model y SRD completos: `../business-model/` (Espacios 1–2 aprobados; Gate 2 condicional).
- Docs técnicos: `docs/firma-digital-gaudi.md` (modelo híbrido de firma), `docs/integracion-github-business-models.md` (GitHub App + port de GitHubService), `services/hunter-core/docs/ARCHITECTURE.md` (pipeline BM→UNSPSC→match).
- Datos: `docs/sicop/202606.zip` (corpus de validación retrospectiva) + diccionario de datos oficial.
- Personas y journeys: `../business-model/srd/personas.yml` y `journeys.md`.

## Convenciones

- Makefile `env-recurso-verbo` (patrón altrupets). `make help` como índice.
- Diagramas siempre en Mermaid, orientación vertical (`flowchart TB`).
- Español para docs y contenido de usuario; código e identificadores en inglés.
