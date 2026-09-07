# ADR 0003: Estilo de despliegue en la nube

## Contexto

AulaViva ya definió en el ADR 0002 un estilo arquitectónico de monolito modular a nivel de código.
Ahora corresponde decidir cómo se despliega ese diseño en la nube, considerando que el Servicio IA
(Python/RAG) tiene un stack y necesidades de escalado distintas al Backend (Node.js).

## Alternativas

**Monolito único**
Todo (Backend + lógica IA) en un solo contenedor Docker.

**Híbrido**
Backend Node en un contenedor, Servicio IA en otro contenedor separado, ambos desplegados de forma
independiente pero dentro del mismo sistema.

## Decisión

Se adopta el enfoque **híbrido**: el Backend (Node.js) y el Servicio IA (Python/RAG) se despliegan
como dos contenedores independientes. El Frontend (React) se sirve como sitio estático aparte.

## Justificación

- El Servicio IA necesita escalar de forma distinta al Backend (picos de uso del tutor IA en época
  de evaluaciones), por lo que separar sus recursos evita que ambos compitan por CPU/memoria.
- Mantiene la simplicidad operacional del monolito modular a nivel de código, sin fragmentar en
  microservicios completos, que agregarían complejidad innecesaria en esta etapa.
- Permite escalar el Servicio IA horizontalmente sin afectar la disponibilidad del Backend.

## Consecuencias positivas

- Escalado independiente por carga real de cada componente.
- Aísla fallas: si el Servicio IA falla, el Backend sigue funcionando para el resto de funciones.
- Facilita medir costos de IA (FinOps) por separado del resto del sistema.

## Consecuencias negativas

- Se necesita orquestar dos despliegues en vez de uno.
- Requiere definir comunicación de red entre Backend y Servicio IA (latencia adicional).

## Fecha

07-09-2026

## Autor

Gerardo González
