# hunter-core

Servicio Python de LicitaNext: pipeline de ingesta de **datos abiertos SICOP**
(CSV/JSON) y motor de match de carteles por código **UNSPSC**.

## Endpoints

| Método | Ruta                | Descripción                          |
| ------ | ------------------- | ------------------------------------ |
| GET    | `/health`           | Healthcheck (probes de Kubernetes)   |
| GET    | `/api/v1/carteles`  | Lista de carteles (vacía por ahora)  |

## Desarrollo local

```bash
# con uv (recomendado)
uv venv
uv pip install -e '.[dev]'

# o con pip
python -m venv .venv && source .venv/bin/activate
pip install -e '.[dev]'

# correr la API
python -m hunter_core        # http://localhost:8000

# tests
pytest

# lint
ruff check .
```

Ver [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) para el plan del pipeline
y la ruta de migración a KNative.
