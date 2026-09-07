# Servicios gestionados por contenedor - AulaViva

## Frontend (React)
**Servicio gestionado:** Vercel o Netlify
**Justificación:** Despliegue estático con CDN global, HTTPS y CI/CD automático incluido, costo bajo para tráfico moderado.

## Backend (Node.js)
**Servicio gestionado:** Google Cloud Run / AWS App Runner
**Justificación:** Escalado automático a cero, pago por uso, ideal para un backend stateless.

## Base de Datos (PostgreSQL)
**Servicio gestionado:** Cloud SQL / Amazon RDS
**Justificación:** Backups automáticos, alta disponibilidad gestionada, sin operar el motor de base de datos manualmente.

## Servicio IA (Python/RAG)
**Servicio gestionado:** Cloud Run + LLM gestionado (Vertex AI o Amazon Bedrock)
**Justificación:** Escalado independiente del backend, y el LLM gestionado evita mantener infraestructura de modelos propia.

## Nota de costos (FinOps)

El Servicio IA es el componente de mayor riesgo de costo por uso de LLM. Se recomienda monitorear
consumo de tokens por tenant desde el inicio.
