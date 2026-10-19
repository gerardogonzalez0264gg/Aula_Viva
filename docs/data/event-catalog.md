# Catálogo de eventos — AulaViva

## 1. Convenciones

Los eventos representan hechos que ya ocurrieron. Sus nombres se escriben en pasado, en minúsculas y separados por puntos.

Todo evento debe incluir:
- `event_id`: identificador único.
- `event_type`: nombre del evento.
- `event_version`: versión del contrato.
- `occurred_at`: fecha y hora del evento.
- `tenant_id`: colegio al que pertenece.
- `aggregate_id`: identificador de la entidad principal.
- `trace_id`: identificador para seguir la operación.
- `data`: información específica del evento.

Los eventos publicados son inmutables. Si cambia el contrato, se incrementa su versión.

## 2. Catálogo de eventos

| N.º | Evento | Productor | Consumidores | Datos principales |
|---:|---|---|---|---|
| 1 | `tenant.registered` | Identidad | Gestión Académica | tenant_id, name |
| 2 | `user.registered` | Identidad | Gestión Académica, Auditoría | user_id, role |
| 3 | `consent.recorded` | Identidad | Tutor IA, Auditoría | user_id, consent_type, version |
| 4 | `course.created` | Gestión Académica | Evaluaciones, Tutor IA | course_id, name, teacher_id |
| 5 | `student.enrolled` | Gestión Académica | Evaluaciones, Analítica | course_id, student_id |
| 6 | `course.material.added` | Gestión Académica | Tutor IA | course_id, material_id, content_version |
| 7 | `evaluation.created` | Evaluaciones | Auditoría | evaluation_id, course_id, created_by |
| 8 | `evaluation.published` | Evaluaciones | Analítica, Notificaciones | evaluation_id, course_id, due_at |
| 9 | `attempt.started` | Evaluaciones | Analítica | attempt_id, evaluation_id, student_id |
| 10 | `attempt.submitted` | Evaluaciones | Corrector, Analítica | attempt_id, evaluation_id, submitted_at |
| 11 | `evaluation.graded` | Evaluaciones | Analítica | attempt_id, score, correct_count, total_count |
| 12 | `feedback.generated` | Evaluaciones | Estudiante, Analítica | attempt_id, feedback_version |
| 13 | `tutor.question.received` | Tutor IA | Servicio IA, Analítica | session_id, course_id, question_id |
| 14 | `tutor.answer.generated` | Servicio IA | Tutor IA, Analítica | session_id, question_id, answer_id |
| 15 | `progress.updated` | Analítica | Dashboard | student_id, course_id, progress_percent |

## 3. Estructura común de un evento

Ejemplo de `evaluation.graded`:

    {
      "event_id": "evt_001",
      "event_type": "evaluation.graded",
      "event_version": "1.0",
      "occurred_at": "2026-10-18T12:30:00Z",
      "tenant_id": "tenant_123",
      "aggregate_id": "attempt_456",
      "trace_id": "trace_789",
      "data": {
        "attempt_id": "attempt_456",
        "evaluation_id": "evaluation_101",
        "student_id": "student_202",
        "score": 85,
        "correct_count": 17,
        "total_count": 20
      }
    }

## 4. Broker seleccionado

Se propone Cloud Pub/Sub para el MVP si AulaViva se despliega en Google Cloud. Es un servicio administrado que permite comunicar componentes de forma asíncrona.

Kafka se evaluará si en el futuro se necesita un volumen elevado de eventos, streaming o reproducción extensa del historial.

## 5. Garantías de entrega

Se asume entrega at-least-once: un evento puede recibirse más de una vez.

Para evitar duplicados:
- Cada evento tendrá un `event_id` único.
- Los consumidores registrarán los eventos procesados.
- Se aplicarán reintentos ante errores temporales.
- Los mensajes que fallen repetidamente se enviarán a una cola de mensajes fallidos.

## 6. Patrón Outbox

Cuando una operación modifica datos y debe publicar un evento, ambos se guardan en la misma transacción PostgreSQL.

Un proceso relay consulta la tabla Outbox, publica los eventos en el broker y registra su publicación. Si falla, podrá reintentarlo.

## 7. Seguridad

No publicar contraseñas, tokens ni datos personales innecesarios. Los consumidores deben verificar la autorización del tenant antes de acceder a los datos del colegio.
