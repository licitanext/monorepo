# Firma Digital CR — GAUDI, componenteFirmaCR y estrategia de integración

> Investigación 2026-07-03 (fuentes: PDFs oficiales BCCR leídos completos + sicop.go.cr/componenteFirmaCR + RACSA). Documento de referencia para la arquitectura del copiloto.

## Conclusión ejecutiva

**Modelo híbrido de firma** (decisión de arquitectura por defecto):

1. **Dentro de LicitaNext (vía GAUDI, canal público)**: firma de documentos propios — declaraciones, mandatos, borradores de oferta en PDF. LicitaNext se registra como *Suscriptor* del BCCR y embebe la pantalla de firma de GAUDI con marca propia. UX in-app real.
2. **Presentación oficial en SICOP**: paso final **asistido** (ventana embebida/deep link + checklist del agente). El acto formal está atado al `componenteFirmaCR` del portal de SICOP; no hay evidencia de API pública de presentación programática.

⚠️ **Riesgo técnico #1 a validar con RACSA/SICOP**: ¿existe mecanismo de presentación programática o integración de componenteFirmaCR en apps de terceros? Hasta confirmar, NO prometer "presentación 100% in-app" en marketing ni pitch.

## GAUDI (BCCR) — el firmador nacional

- **Qué es**: Gestor de Autenticaciones y Firmas Digitales del BCCR. Una entidad "Suscriptor" solicita firmas/autenticaciones a personas físicas con su tarjeta de Firma Digital nacional.
- **Flujo**: app del Suscriptor → solicitud a GAUDI (WCF/REST) → GAUDI muestra pantalla con marca del Suscriptor → usuario ingresa código + PIN con tarjeta+lector → GAUDI notifica resultado vía webhook del Suscriptor.
- **Canal público** (el nuestro): cualquier entidad; `firmadorexterno.bccr.fi.cr`, REST en `servicios-rest-firmador.gaudi.sinpe.fi.cr` (endpoints `FirmarDocumento`, `Autenticar`, `AdminSolicitudes`; OpenAPI). Canal privado: solo entidades SINPE (bancos) — no aplica.

## Requisitos para ser Suscriptor (onboarding LicitaNext → BCCR)

1. **Certificado de Agente Electrónico** de la jerarquía nacional (persona jurídica; lo tramita el representante legal). Cadena: CA Raíz Nacional CR → CA Política PJ → CA SINPE PJ → entidad.
2. **Identidad de marca** en Central Directo (nombre + logo 184×84px).
3. **Sitio de notificaciones** propio: HTTPS puerto 8443, asegurado con el mismo certificado, implementando el contrato exacto del BCCR (`ResultadoDeFirma.NotifiqueLaRespuesta`).
4. **Pruebas** en ambiente de test con escenarios documentados.
5. **Habilitación firmada por el apoderado legal** con su propia tarjeta.
6. Checklist final en verde → producción.

**Costo de suscripción institucional: NO publicado** — consultar a BCCR/Central Directo (gap abierto). Firma de persona física: ~$50 (banco) o ₡5.000 + $10 (firma digital móvil), vence cada 2 años.

## componenteFirmaCR (SICOP / RACSA)

- Desarrollado por RACSA, **independiente de GAUDI**. Sin applets ni extensiones: **agente local + WebSocket + HTML5** que da acceso al lector de tarjetas desde el navegador (Chrome 55+, Firefox 52+, Edge 40+, Safari 10+). Firma XML/PDF, AES/RSA, OCSP/CRL.
- RACSA lo describe como "disponible para diferentes plataformas Web" → integrabilidad por terceros **no confirmada públicamente**. Confirmar directo con RACSA.

## Relación con el SDK hacienda-cr

Una sola **PKI nacional** (CA Raíz Nacional CR, BCCR rector): la misma tarjeta/certificado sirve para Hacienda (XAdES-EPES en facturación), GAUDI y SICOP. Pero son **tres integraciones distintas** sobre esa base: el conocimiento de hacienda-cr (certificados, PIN, lectores) es reutilizable conceptualmente; el código de integración con GAUDI y SICOP se escribe aparte contra sus contratos.

## Impacto en el roadmap

- **MVP**: no requiere GAUDI (pipeline datos abiertos → match → alerta + borrador descargable).
- **Copiloto v1**: integración GAUDI como Suscriptor (firma in-app de documentos propios) + presentación asistida en SICOP.
- **Antes de v1**: (a) consultar costo/tiempos de suscripción GAUDI al BCCR; (b) consultar a RACSA sobre componenteFirmaCR/presentación programática; (c) constituir la entidad legal (el certificado de Agente Electrónico exige persona jurídica con representante).

Guía CENDEISSS (caso real de implementación institucional) descargada en scratchpad para consulta futura.
