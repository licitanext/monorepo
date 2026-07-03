# Diseño: Experimento MVP "Paquete Fundador" — LicitaNext

**Fecha:** 2026-07-03 · **Estado:** Aprobado por el fundador (brainstorm con visual companion)
**Fuente de verdad operativa:** `licitanext/business-model/02-solucion-validacion/16-experimento-mvp.md` (este spec resume las decisiones y su porqué)

## Qué se decidió (4 decisiones del estrés + base)

### Base: Concierge → Wizard of Oz
Valida disposición a pagar (S1) + operabilidad del ciclo completo, cobrando desde el día 1 con el pipeline a medio construir. Confianza crítica del dominio (legal/dinero) descarta pre-order frío; ventana competitiva de 12–18 meses descarta audience building como MVP.

### D1 — Escalera de precio calibrada por Van Westendorp
- Slots 1–5: **$99 fijo** ("precio fundador", deliberadamente ≤PMC) — velocidad de señal + urgencia honesta.
- Slots 6–10: **precio = OPP** medido con las 4 preguntas VW en las ≥5 entrevistas de Fase 7 (placeholder $249). El dato fija el precio, no el deseo.
- Criterio de invalidación agregado: peldaño 1 agotado + 0 ventas de peldaño 2 en 3 semanas → S1 tocado.
- Salida: 2 puntos reales de curva de demanda + curvas VW → triangulación de pricing en Fase 9.

### D2 — Cupo mixto con dos relojes
~6 slots a empresas ya registradas en SICOP (reloj de 90 días desde compra → alimentan el Go/No-Go del 31-oct) + ~4 primerizos puros (reloj desde habilitación completa → validan onboarding sin contaminar el veredicto con burocracia municipal ajena).

### D3 — La conversión resuelve la Fase 9
Al cerrar el concierge, cada cliente elige entre las 3 estructuras de ingresos del módulo 08 (A suscripción+gestionado / B por-oferta+fee / C flat) con dinero real. ≥50% elige alguna = valida; la distribución A/B/C decide el modelo de ingresos. Si B domina → validar success fee con abogado antes de operarla.

### D4 — Garantía por causa atribuible
Devolución 100% si el cliente no llega a oferta presentada por causa nuestra; si el bloqueo es suyo, el diagnóstico es el valor. Tasa de devoluciones = métrica de calidad (✅ 0–1 · ❌ ≥3).

## Criterios completos del Go/No-Go (2026-10-31)

Vendidos ≥7/10 (❌<4) · Ofertas válidas ≥5 en reloj limpio (❌<2) · Exclusiones 0 (❌≥2) · Conversión ≥50% (❌<20%) · Peldaño 2 ≥2 (❌ 0 en 3 sem) · Esfuerzo founder ≤8h/sem (❌>20) · Devoluciones 0–1 (❌≥3) · Bonus: ≥1 adjudicación.

## Prerrequisitos
≥5 entrevistas de solución con VW completo + scorecard ≥PARCIAL · pipeline v0 con matching retrospectivo ≥70% (KR2.3) · primera oferta de dogfooding presentada (KR3.1).

## Blind spots aceptados
Usabilidad self-serve (se valida en transición Wizard of Oz) · CAC escalable (post-PMF) · precio concierge ≠ precio SaaS (mitigado por D3).

## Artefactos
- Experimento operativo: `business-model/02-solucion-validacion/16-experimento-mvp.md`
- Guion de entrevista con VW: `business-model/02-solucion-validacion/15-entrevista-solucion.md`
- Pantallas del companion: `.superpowers/brainstorm/1161273-1783082661/content/` (overview, escalera, diseño final)
