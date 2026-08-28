Feature: Evaluación auto-corregida

  Como docente,
  quiero crear una evaluación auto-corregida,
  para reducir el tiempo dedicado a corregir respuestas.

  Scenario: El estudiante responde una evaluación correctamente
    Given que el docente ha creado una evaluación
    And la evaluación contiene preguntas con respuestas configuradas
    When el estudiante envía sus respuestas
    Then el sistema corrige automáticamente la evaluación
    And muestra el resultado obtenido

  Scenario: El estudiante deja preguntas sin responder
    Given que el estudiante está respondiendo una evaluación
    And existen preguntas sin responder
    When el estudiante envía la evaluación
    Then el sistema identifica las preguntas sin responder
    And las considera en el resultado según las reglas de la evaluación

  Scenario: Error durante la corrección
    Given que el estudiante ha enviado una evaluación
    When ocurre un error durante el proceso de corrección
    Then el sistema informa que no pudo completar la corrección
    And evita mostrar un resultado incorrecto
