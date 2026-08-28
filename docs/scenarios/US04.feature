Feature: Feedback automático

  Como estudiante,
  quiero recibir feedback después de una evaluación,
  para comprender mis errores.

  Scenario: El estudiante obtiene feedback después de una evaluación
    Given que el estudiante ha terminado una evaluación
    And el sistema ha corregido sus respuestas
    When el estudiante consulta el resultado
    Then el sistema muestra el resultado de la evaluación
    And muestra información sobre sus respuestas incorrectas

  Scenario: El estudiante responde correctamente todas las preguntas
    Given que el estudiante ha terminado una evaluación
    And todas sus respuestas son correctas
    When el sistema genera el resultado
    Then el sistema indica que no existen respuestas incorrectas
    And muestra el resultado obtenido

  Scenario: Error al generar el feedback
    Given que la evaluación ya fue corregida
    When ocurre un error al generar el feedback
    Then el sistema informa que el feedback no está disponible
    And mantiene disponible el resultado de la evaluación
