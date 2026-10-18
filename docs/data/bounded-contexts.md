# Bounded Contexts — AulaViva

## 1. Objetivo

Separar el sistema AulaViva en contextos con responsabilidades claras para gestionar colegios, usuarios, cursos, evaluaciones y tutoría mediante inteligencia artificial.

## 2. Contextos del sistema

### Identidad y Tenants
- Responsabilidad: gestionar colegios, usuarios, roles y membresías.
- Entidades principales: Tenant, User y Membership.
- Evento: `user.registered`.

### Gestión Académica
- Responsabilidad: gestionar cursos, estudiantes, matrículas y materiales.
- Entidades principales: Course, Enrollment y CourseMaterial.
- Evento: `course.created`.

### Evaluaciones
- Responsabilidad: crear evaluaciones, recibir respuestas y calcular resultados.
- Entidades principales: Evaluation, Question, Attempt y Answer.
- Evento: `evaluation.published`.

### Tutor IA
- Responsabilidad: responder preguntas utilizando los materiales autorizados de los cursos.
- Entidades principales: TutorSession y TutorMessage.
- Evento: `tutor.answer.generated`.

### Analítica y Seguimiento
- Responsabilidad: consultar resultados y medir el progreso de los estudiantes.
- Entidades principales: StudentProgress y LearningMetric.
- Evento: `progress.updated`.

## 3. Relaciones entre contextos

- Identidad proporciona los usuarios y roles.
- Gestión Académica proporciona cursos y matrículas.
- Evaluaciones utiliza los cursos para crear pruebas y registrar resultados.
- Tutor IA utiliza los materiales autorizados para responder preguntas.
- Analítica recibe eventos para actualizar indicadores y mostrar el progreso.

## 4. Decisiones

- PostgreSQL será la base de datos principal.
- Los contextos compartirán identificadores, evitando depender directamente de los modelos internos de otros contextos.
- Los datos de cada colegio estarán aislados mediante `tenant_id`.
- Se utilizará el patrón Outbox para publicar eventos de forma fiable.
- No se implementará Event Sourcing completo en la primera versión.
- Los consumidores de eventos deberán evitar procesar dos veces el mismo evento.
