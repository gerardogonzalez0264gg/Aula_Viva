# Catálogo de Eventos - AulaViva

Un evento cuenta algo que **ya pasó**. Por eso el nombre va en pasado y con el formato
`recurso.accion.pasado`. Un evento no se modifica nunca después de creado.

## Datos que lleva todo evento (el "sobre")

| Campo | Para qué sirve |
|---|---|
| `event_id` | Número único del evento. Sirve para no procesarlo dos veces. |
| `event_type` | Nombre del evento (por ejemplo `evaluation.exam.graded`). |
| `event_version` | Versión del formato del evento (empieza en `1.0`). |
| `occurred_at` | Fecha y hora en que pasó. |
| `tenant_id` | Colegio al que pertenece el dato. |
| `aggregate_id` | Id del objeto principal (curso, evaluación, etc.). |
| `trace_id` | Id para seguir el recorrido de una petición en los logs. |
| `data` | Los datos propios de cada evento. |

## Lista de eventos (15)

| # | Evento | Versión | Lo produce | Lo consumen | Campos dentro de `data` |
|---|---|---|---|---|---|
| 1 | `tenant.school.registered` | 1.0 | Identidad y Colegios | Académico | `school_name`, `region` |
| 2 | `user.account.created` | 1.0 | Identidad y Colegios | Académico | `user_id`, `role` (docente o estudiante) |
| 3 | `guardian.consent.recorded` | 1.0 | Identidad y Colegios | Tutor IA | `student_id`, `guardian_name`, `accepted` |
| 4 | `course.course.created` | 1.0 | Académico | Evaluaciones, Tutor IA | `course_id`, `name`, `teacher_id` |
| 5 | `enrollment.user.enrolled` | 1.0 | Académico | Evaluaciones | `enrollment_id`, `user_id`, `course_id` |
| 6 | `notes.file.uploaded` | 1.0 | Académico | Tutor IA | `notes_id`, `course_id`, `file_name` |
| 7 | `notes.file.indexed` | 1.0 | Tutor IA | Académico | `notes_id`, `chunks_count` |
| 8 | `evaluation.draft.requested` | 1.0 | Evaluaciones | Tutor IA | `evaluation_id`, `course_id`, `notes_ids` |
| 9 | `evaluation.draft.generated` | 1.0 | Tutor IA | Evaluaciones | `evaluation_id`, `questions_count` |
| 10 | `evaluation.exam.published` | 1.0 | Evaluaciones | Académico | `evaluation_id`, `course_id`, `title` |
| 11 | `evaluation.answers.submitted` | 1.0 | Evaluaciones | Evaluaciones (corrector) | `submission_id`, `evaluation_id`, `student_id` |
| 12 | `evaluation.exam.graded` | 1.0 | Evaluaciones | Evaluaciones, Académico | `submission_id`, `score`, `max_score` |
| 13 | `feedback.report.generated` | 1.0 | Evaluaciones | Académico | `submission_id`, `wrong_questions` |
| 14 | `tutor.question.asked` | 1.0 | Tutor IA | Tutor IA | `session_id`, `course_id`, `question` |
| 15 | `tutor.usage.recorded` | 1.0 | Tutor IA | Costos (FinOps) | `session_id`, `tokens_in`, `tokens_out` |

## Ejemplo completo

```json
{
  "event_id": "01J9ZQ4X7K2M",
  "event_type": "evaluation.exam.graded",
  "event_version": "1.0",
  "occurred_at": "2026-10-19T14:22:31Z",
  "tenant_id": "colegio-001",
  "aggregate_id": "submission-123",
  "trace_id": "c8f2b1a9",
  "data": {
    "submission_id": "submission-123",
    "score": 18,
    "max_score": 20
  }
}
```

## Reglas

- Un evento puede llegar **más de una vez**. Por eso quien lo recibe revisa el `event_id` y no repite el trabajo.
- Los eventos se guardan primero en la tabla `outbox_event` (junto con el dato) y luego se publican en Pub/Sub. Así no se pierde ninguno.
- Si hay que cambiar un evento de forma incompatible, se sube la versión (`2.0`) y se mantiene la anterior un tiempo.
