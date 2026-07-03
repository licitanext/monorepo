"""Punto de entrada: `python -m hunter_core`."""

from __future__ import annotations

import os

import uvicorn


def main() -> None:
    uvicorn.run(
        "hunter_core.app:app",
        host=os.environ.get("HUNTER_HOST", "0.0.0.0"),  # noqa: S104
        port=int(os.environ.get("HUNTER_PORT", "8000")),
        reload=False,
    )


if __name__ == "__main__":
    main()
