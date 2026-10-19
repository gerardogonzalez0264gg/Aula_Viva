# ADR 0004: Datos y arquitecturas event-driven

- **Estado:** Propuesta
- **Fecha:** 18-10-2026
- **Proyecto:** AulaViva

## 1. Contexto

AulaViva es una plataforma educativa que administra colegios, usuarios, cursos, materiales, evaluaciones y un tutor IA.

El sistema necesita mantener la integridad de las matrículas y los resultados, aislar los datos de cada colegio y permitir que sus componentes se comuniquen de forma asíncrona.

## 2. Decisión de persistencia

Se utilizará PostgreSQL como fuente de verdad principal porque permite transacciones ACID, relaciones entre entidades, integridad referencial y consultas complejas.

Los datos principales serán:
- Usuarios, colegios y membresías.
- Cursos, matrículas y materiales.
- Evaluaciones, preguntas, intentos y respuestas.
- Sesiones y mensajes del tutor.

Redis podrá incorporarse como caché si las mediciones demuestran que es necesario.

## 3. Decisión sobre eventos

Se propone Cloud Pub/Sub como broker de eventos administrado, sujeto a que el despliegue utilice Google Cloud y a la validación de costos.

Los eventos comunicarán hechos ocurridos en el sistema, como la publicación de una evaluación o la generación de un resultado.

Se utilizará Transactional Outbox para registrar los eventos junto con los cambios de negocio en una misma transacción PostgreSQL.

## 4. Patrones seleccionados

### Outbox
Se elige para evitar que una modificación en la base de datos se confirme sin que quede registrado el evento que debe publicarse.

### CQRS
Se utilizará solo cuando las consultas necesiten un modelo de lectura distinto del modelo de escritura. Inicialmente se mantendrán consultas simples sobre PostgreSQL.

### Event Sourcing
No se implementará en el MVP. La complejidad adicional no se justifica sin una necesidad concreta de reconstrucción completa del estado a partir de eventos.

### Saga
Se considerará si aparecen operaciones distribuidas que involucren varios servicios y necesiten acciones compensatorias ante fallos.

## 5. Bounded contexts

El sistema se dividirá en Identidad y Tenants, Gestión Académica, Evaluaciones, Tutor IA y Analítica y Seguimiento.

Durante el MVP estos contextos podrán implementarse como módulos del backend, sin necesidad de convertirlos inmediatamente en microservicios.

## 6. Alternativas consideradas

| Alternativa | Ventaja | Desventaja | Decisión |
|---|---|---|---|
| PostgreSQL | Transacciones y relaciones | Requiere diseñar índices | Elegido |
| MongoDB | Documentos flexibles | Menos adecuado como núcleo relacional del dominio | No elegido |
| Redis | Acceso rápido por clave | No será la fuente principal de verdad | Solo caché si se necesita |
| Kafka | Streaming y reproducción de eventos | Mayor complejidad operacional | Evaluar en el futuro |
| Cloud Pub/Sub | Servicio administrado | Dependencia de Google Cloud y costos variables | Propuesto |
| Event Sourcing | Reconstrucción del estado | Mayor complejidad | No en el MVP |

## 7. Consecuencias

### Positivas
- Integridad de los datos académicos.
- Comunicación asíncrona entre componentes.
- Menor acoplamiento entre contextos.
- Posibilidad de escalar componentes cuando sea necesario.

### Negativas
- Outbox necesita un proceso relay y reintentos.
- La entrega de eventos puede ser duplicada.
- Algunas vistas pueden actualizarse con retraso.
- La seguridad multi-tenant requiere validación en todas las operaciones.

## 8. Validación

- Verificar las relaciones del DER.
- Comprobar que un colegio no pueda consultar los datos de otro.
- Probar reintentos de publicación Outbox.
- Verificar que un consumidor no procese dos veces el mismo evento.
- Revisar costos y necesidades reales antes de incorporar tecnologías adicionales.
