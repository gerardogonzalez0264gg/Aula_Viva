Feature: Generación de evaluación desde apuntes

  Como docente,
  quiero generar una evaluación desde mis apuntes,
  para crear actividades de evaluación rápidamente.

  Scenario: Generación exitosa de una evaluación
    Given que el docente tiene apuntes disponibles en un curso
    When solicita generar una evaluación
    Then el sistema genera preguntas utilizando los contenidos de los apuntes
    And muestra la evaluación generada al docente

  Scenario: Los apuntes contienen información insuficiente
    Given que el docente ha seleccionado apuntes con poco contenido
    When solicita generar una evaluación
    Then el sistema informa que los contenidos disponibles son insuficientes
    And no genera una evaluación incompleta

  Scenario: Error durante la generación
    Given que el docente ha seleccionado apuntes válidos
    When ocurre un error durante la generación de la evaluación
    Then el sistema informa que no pudo generar la evaluación
    And permite al docente volver a intentarlo
