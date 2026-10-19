# ADR 0004: Datos y eventos

## Contexto

AulaViva guarda cursos, matrículas, evaluaciones, resultados y apuntes para el tutor IA.
Además, algunas cosas pasan "en cadena": cuando un estudiante envía una evaluación,
hay que corregirla, generar el feedback y actualizar el panel del docente.
Era necesario decidir dónde se guardan los datos y cómo se avisan entre sí los módulos.
Todo debe respetar el aislamiento entre colegios y la protección de datos de menores.

## Alternativas

**Base de datos**
- PostgreSQL para todo.
- PostgreSQL + base documental (MongoDB) para los apuntes y el tutor IA.
- PostgreSQL + base especializada en vectores (Pinecone o Qdrant).

**Aviso entre módulos (broker)**
- Google Pub/Sub.
- Kafka.
- RabbitMQ.

**Patrones**
- Outbox, CQRS, Event Sourcing y Saga.

## Decisión

- **Base de datos:** una sola base **PostgreSQL** (Cloud SQL). Para el tutor IA se usa la extensión **pgvector**,
  que guarda los textos de los apuntes dentro de la misma base.
- **Aislamiento entre colegios:** todas las tablas llevan `tenant_id` y se filtran por él.
- **Broker de eventos:** **Google Pub/Sub** (servicio gestionado).
- **Outbox: sí.** Cada evento se guarda en la tabla `outbox_event` junto con el dato, y luego se publica.
- **CQRS: no por ahora.** Una sola forma de leer y escribir es suficiente para el MVP.
- **Event Sourcing: no.** No necesitamos reconstruir el pasado completo con eventos.
- **Saga: no por ahora.** El monolito modular guarda todo en una sola base, así que no hay transacciones repartidas.
- **Eventos repetidos:** se asume que un evento puede llegar dos veces. Quien lo recibe revisa el `event_id`.

## Justificación

- Es mejor empezar con PostgreSQL y agregar algo nuevo solo cuando se demuestre que no alcanza.
- pgvector evita operar otra base y mantiene los apuntes de cada colegio junto a sus demás datos y con el mismo `tenant_id`.
- Pub/Sub encaja con Cloud Run y Vertex AI (ADR 0003): no hay servidores que mantener y se paga por uso.
- Outbox es barato de hacer y evita perder eventos si el broker falla justo después de guardar el dato.
- CQRS y Event Sourcing agregarían mucha complejidad y no resuelven un problema que hoy tengamos.

## Consecuencias positivas

- Menos piezas que operar: una base y un broker.
- Los datos de cada colegio quedan aislados con un criterio simple (`tenant_id`).
- Los eventos no se pierden y se pueden seguir con el `trace_id`.
- Se puede medir el uso de tokens por colegio con el evento `tutor.usage.recorded`.

## Consecuencias negativas

- Hay que crear y mantener la tabla `outbox_event` y el proceso que publica.
- pgvector puede quedarse corto si los apuntes crecen mucho; habría que migrar a una base de vectores.
- Todos los que reciben eventos deben ser capaces de ignorar los repetidos.
- Una sola base es un punto único de falla (se reduce con la alta disponibilidad de Cloud SQL).

## Documentos relacionados

- `docs/data/der.png` y `docs/data/der.dbml`
- `docs/data/event-catalog.md`
- `docs/data/bounded-contexts.md`

## Fecha

19-10-2026

## Autor

Gerardo González
