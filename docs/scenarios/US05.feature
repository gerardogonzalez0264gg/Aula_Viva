Feature: Resultados de evaluaciones

  Como docente,
  quiero visualizar los resultados de mis estudiantes,
  para conocer su desempeño.

  Scenario: El docente consulta resultados disponibles
    Given que existen estudiantes que han realizado una evaluación
    When el docente consulta los resultados
    Then el sistema muestra el desempeño de los estudiantes
    And permite visualizar sus resultados

  Scenario: No existen evaluaciones realizadas
    Given que el curso no tiene evaluaciones respondidas
    When el docente consulta los resultados
    Then el sistema informa que no existen resultados disponibles

  Scenario: Error al cargar los resultados
    Given que existen evaluaciones realizadas
    When ocurre un error al cargar los resultados
    Then el sistema informa que no pudo cargar los resultados
    And permite al docente volver a intentarlo
