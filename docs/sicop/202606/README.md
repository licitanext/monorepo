# SICOP — volcado de datos abiertos (202606)

Volcado periódico de datos abiertos de **SICOP** (Sistema Integrado de Compras
Públicas de Costa Rica), correspondiente a **junio 2026**.

## Formato

Los CSVs originales (delimitador `;`) se convirtieron a **Parquet** (columnar,
snappy) para reducir peso y facilitar consumo analítico por `hunter-core`.

| Dataset | Parquet | Filas aprox |
| --- | --- | --- |
| InvitacionProcedimiento | `InvitacionProcedimiento.parquet` | ~1.69M |
| OrdenPedido | `OrdenPedido.parquet` | — |
| Proveedores | `Proveedores.parquet` | — |
| Remates | `Remates.parquet` | — |
| Ofertas | `Ofertas.parquet` | — |
| (resto) | `*.parquet` | — |

## Origen y reproducción

- Fuente: https://www.sicop.go.cr/ (datos abiertos).
- El `.zip` original se dejó fuera de git (~~52 MB); el archivo
  `InvitacionProcedimiento.csv` (~316 MB) no se committea.
- Re-extraer: descargar `202606.zip` de SICOP, descomprimir y convertir con
  `pyarrow` (`csv` → `parquet`, `delimiter=";"`).

## Nota

Dos datasets (`LineasContratadas`, `LineasRecibidas`) tienen filas irregulares
(más columnas que el header); se conservaron solo las filas alineadas al header.
