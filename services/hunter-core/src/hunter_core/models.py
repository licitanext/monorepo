"""Modelos de dominio de hunter-core.

Por ahora sólo el `Cartel` (licitación/procedimiento SICOP). El esquema
definitivo se derivará del diccionario de datos de datos abiertos SICOP
(ver docs/sicop/).
"""

from __future__ import annotations

from datetime import date

from pydantic import BaseModel


class Cartel(BaseModel):
    """Un cartel de contratación publicado en SICOP."""

    numero_procedimiento: str
    descripcion: str
    institucion: str
    unspsc: str | None = None
    fecha_publicacion: date | None = None
    fecha_cierre: date | None = None
