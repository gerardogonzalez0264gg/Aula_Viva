Feature: Tutor IA

  Como estudiante,
  quiero realizar preguntas al tutor IA,
  para resolver mis dudas utilizando los contenidos del curso.

  Scenario: El tutor responde una pregunta relacionada con el curso
    Given que el estudiante está dentro de un curso
    And el curso tiene apuntes disponibles
    When el estudiante realiza una pregunta relacionada con esos contenidos
    Then el tutor IA responde utilizando la información disponible del curso

  Scenario: El estudiante realiza una pregunta fuera del contenido
    Given que el estudiante está dentro de un curso
    When realiza una pregunta que no está relacionada con los contenidos disponibles
    Then el tutor informa que no encuentra información suficiente en el curso
    And evita presentar la respuesta como contenido del curso

  Scenario: El tutor IA no está disponible
    Given que el estudiante está dentro de un curso
    When realiza una pregunta y el tutor IA no está disponible
    Then el sistema informa que el tutor no puede responder
    And permite que el estudiante vuelva a intentarlo
