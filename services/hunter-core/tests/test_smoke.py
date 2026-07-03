"""Tests de humo de la API de hunter-core."""

from __future__ import annotations

from fastapi.testclient import TestClient

from hunter_core.app import app

client = TestClient(app)


def test_health_ok() -> None:
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json()["status"] == "ok"


def test_carteles_vacio() -> None:
    resp = client.get("/api/v1/carteles")
    assert resp.status_code == 200
    assert resp.json() == []
