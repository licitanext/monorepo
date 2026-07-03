# Dockerfile multi-stage para hunter-core (LicitaNext)

# Stage 1: build del wheel
FROM python:3.12-slim AS builder
WORKDIR /app
COPY pyproject.toml README.md ./
COPY src/ src/
RUN pip install --no-cache-dir build && \
    python -m build --wheel && \
    pip install --no-cache-dir dist/hunter_core-0.1.0-py3-none-any.whl

# Stage 2: imagen de runtime
FROM python:3.12-slim
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

WORKDIR /app
ENV HUNTER_HOST=0.0.0.0 \
    HUNTER_PORT=8000

EXPOSE 8000
RUN useradd -r -s /bin/false appuser
USER appuser

ENTRYPOINT ["python", "-m", "hunter_core"]
