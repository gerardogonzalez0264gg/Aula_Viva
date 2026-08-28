# Backlog - AulaViva

## US01 - Evaluación auto-corregida

**Actor:** Docente

**Como** docente de un curso,  
**quiero** crear una evaluación auto-corregida,  
**para** reducir el tiempo que dedico a corregir las respuestas de mis estudiantes.

### Impacto relacionado

Reducir el tiempo dedicado a corregir evaluaciones.

### Prioridad

**MUST**

### Criterios de aceptación

- La evaluación debe poder ser respondida por los estudiantes.
- El sistema debe corregir automáticamente las respuestas.
- El estudiante debe poder conocer su resultado.
- Si ocurre un error durante la corrección, el sistema debe informar el problema.

---

## US02 - Generación de evaluación desde apuntes

**Actor:** Docente

**Como** docente de un curso,  
**quiero** generar una evaluación a partir de los apuntes de mi curso,  
**para** crear actividades de evaluación de forma más rápida.

### Impacto relacionado

Reducir el tiempo necesario para crear evaluaciones.

### Prioridad

**MUST**

### Criterios de aceptación

- El docente debe poder seleccionar los apuntes de un curso.
- El sistema debe utilizar los apuntes como fuente para generar la evaluación.
- La evaluación generada debe estar relacionada con los contenidos disponibles.
- Si los apuntes son insuficientes, el sistema debe informar al docente.

---

## US03 - Tutor IA

**Actor:** Estudiante

**Como** estudiante,  
**quiero** realizar preguntas al tutor IA utilizando los contenidos de mi curso,  
**para** resolver mis dudas de aprendizaje.

### Impacto relacionado

Permitir que el estudiante resuelva dudas utilizando el contenido del curso.

### Prioridad

**MUST**

### Criterios de aceptación

- El estudiante debe poder realizar una pregunta.
- El tutor debe utilizar los contenidos del curso como contexto.
- La respuesta debe estar relacionada con los contenidos disponibles.
- Si el tutor no puede responder, debe informar al estudiante.

---

## US04 - Feedback automático

**Actor:** Estudiante

**Como** estudiante,  
**quiero** recibir feedback automático después de responder una evaluación,  
**para** comprender mis errores y mejorar mi aprendizaje.

### Impacto relacionado

Permitir que el estudiante comprenda sus errores.

### Prioridad

**SHOULD**

### Criterios de aceptación

- El sistema debe mostrar el resultado de la evaluación.
- El sistema debe identificar las respuestas incorrectas.
- El estudiante debe recibir información que le permita comprender sus errores.
- Si ocurre un error al generar el feedback, el sistema debe informar al estudiante.

---

## US05 - Resultados de evaluaciones

**Actor:** Docente

**Como** docente,  
**quiero** visualizar los resultados de las evaluaciones de mis estudiantes,  
**para** conocer su desempeño y detectar dificultades de aprendizaje.

### Impacto relacionado

Permitir al docente conocer el desempeño de sus estudiantes.

### Prioridad

**SHOULD**

### Criterios de aceptación

- El docente debe poder consultar los resultados.
- El sistema debe mostrar el desempeño de los estudiantes.
- Si no existen evaluaciones realizadas, debe informarlo.
- Si ocurre un error al cargar los resultados, debe informar al docente.

---

# Priorización MoSCoW

| Historia | Prioridad | Justificación |
|---|---|---|
| US01 | MUST | Es necesaria para implementar las evaluaciones auto-corregidas del MVP. |
| US02 | MUST | Permite automatizar la creación de evaluaciones y es una funcionalidad central del proyecto. |
| US03 | MUST | El tutor IA es una de las funcionalidades principales de AulaViva. |
| US04 | SHOULD | Aporta valor al aprendizaje, pero puede implementarse después de la evaluación y tutor IA. |
| US05 | SHOULD | Permite analizar el desempeño y complementa las funcionalidades principales. |
