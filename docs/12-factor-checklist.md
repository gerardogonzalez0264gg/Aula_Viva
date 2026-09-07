# Checklist 12-Factor App - AulaViva

Auditoría de los 12 factores contra los contenedores del C4 L2:
Frontend (React), Backend (Node.js), Base de Datos (PostgreSQL), Servicio IA (Python/RAG).

---

## 1. Codebase
**Estado:** Cumple
**Acción:** Ninguna. Un solo repositorio Git para todo el proyecto, con branches por feature.
**Responsable:** Tech Lead

## 2. Dependencies
**Estado:** Diseño planificado
**Acción:** Declarar dependencias explícitamente con package.json (Node/React) y requirements.txt o pyproject.toml (Python).
**Responsable:** Backend / AI Lead

## 3. Config
**Estado:** No cumple
**Acción:** Sacar cualquier config hardcodeada (URLs, claves) y moverla a variables de entorno (.env) en Backend y Servicio IA.
**Responsable:** Backend Lead

## 4. Backing services
**Estado:** Diseño planificado
**Acción:** Tratar PostgreSQL y el LLM externo como recursos adjuntos, accedidos vía URL/variable de entorno, intercambiables sin tocar código.
**Responsable:** Backend Lead

## 5. Build, release, run
**Estado:** No cumple
**Acción:** Definir pipeline con etapas separadas: build (imagen Docker) → release (config + imagen) → run (contenedor ejecutando).
**Responsable:** DevSecOps Lead

## 6. Processes
**Estado:** Diseño planificado
**Acción:** Backend y Servicio IA deben ser stateless: ninguna sesión de usuario guardada en memoria del proceso.
**Responsable:** Backend / AI Lead

## 7. Port binding
**Estado:** Cumple
**Acción:** Ninguna. El Backend Node expone su propio puerto vía servidor HTTP propio, sin depender de un servidor externo.
**Responsable:** Backend Lead

## 8. Concurrency
**Estado:** No aplica todavía
**Acción:** Definir al momento de escalar: múltiples instancias del Backend/Servicio IA, no threads dentro de un mismo proceso.
**Responsable:** Tech Lead

## 9. Disposability
**Estado:** No cumple
**Acción:** Agregar manejo de señales (SIGTERM) y apagado graceful en Backend y Servicio IA para arranque/cierre rápidos.
**Responsable:** Backend / AI Lead

## 10. Dev/prod parity
**Estado:** Diseño planificado
**Acción:** Usar Docker Compose local con PostgreSQL real (no SQLite) para que el ambiente de desarrollo se parezca a producción.
**Responsable:** DevSecOps Lead

## 11. Logs
**Estado:** No cumple
**Acción:** Los logs deben escribirse a stdout/stderr como stream de eventos, no a archivos locales.
**Responsable:** Backend / AI Lead

## 12. Admin processes
**Estado:** No aplica todavía
**Acción:** Definir cómo se ejecutarán tareas puntuales (migraciones de base de datos, scripts) como procesos aparte, separados del proceso principal.
**Responsable:** Backend Lead

---

## Resumen

| Estado | Cantidad |
|---|---|
| Cumple | 2 |
| No cumple | 4 |
|
