# ADR 0002: Elección del estilo arquitectónico

## Contexto

AulaViva necesita una arquitectura que permita desarrollar y mantener la plataforma educativa, considerando seguridad, escalabilidad y disponibilidad.

## Alternativas

- Monolito modular
- Microservicios

## Decisión

Se utilizará un monolito modular como estilo arquitectónico inicial.

## Justificación

El monolito modular permite mantener una estructura organizada separando las principales funcionalidades del sistema, sin agregar la complejidad operacional de una arquitectura basada en múltiples microservicios.

Además, permite evolucionar posteriormente hacia microservicios si el crecimiento de AulaViva lo requiere.

## Consecuencias positivas

- Menor complejidad inicial.
- Desarrollo más sencillo.
- Facilita la organización del código.
- Permite una futura evolución de la arquitectura.

## Consecuencias negativas

- Puede ser necesario separar módulos en servicios independientes si el sistema crece considerablemente.
- Un problema en la aplicación puede afectar a diferentes funcionalidades.

## Fecha

03-09-2026

## Autor

Gerardo González
