"""API FastAPI de hunter-core.

Superficie mínima para el esqueleto:
  - GET /health              -> readiness/liveness
  - GET /api/v1/carteles     -> lista de carteles (vacía por ahora)

El pipeline real de ingesta de datos abiertos SICOP (descarga CSV/JSON,
normalización, match UNSPSC) se conectará detrás de estos endpoints.
"""

from __future__ import annotations

from fastapi import FastAPI

from hunter_core import __version__
from hunter_core.models import Cartel

app = FastAPI(
    title="LicitaNext · hunter-core",
    version=__version__,
    description="Ingesta de datos abiertos SICOP y match de carteles",
)


@app.get("/health")
async def health() -> dict[str, str]:
    """Healthcheck para probes de Kubernetes."""
    return {"status": "ok", "version": __version__}


@app.get("/api/v1/carteles")
async def list_carteles() -> list[Cartel]:
    """Lista de carteles.

    Devuelve una lista vacía hasta que el pipeline de ingesta esté conectado.
    """
    return []
