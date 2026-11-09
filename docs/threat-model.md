
# Modelo de amenazas STRIDE - AulaViva

## 1. Objetivo

Identificar las principales amenazas de seguridad
de AulaViva y definir medidas para reducir los riesgos
en el backend y el servicio Tutor IA.

## 2. Activos importantes

- Datos personales de estudiantes.
- Información de cursos y evaluaciones.
- Respuestas y calificaciones.
- Credenciales y tokens de autenticación.
- Información procesada por Tutor IA.
- Servicios backend y base de datos.

## 3. Límites de confianza

- Estudiante y plataforma AulaViva.
- Frontend y backend.
- Backend y servicio Tutor IA.
- Servicios internos y base de datos.
- Aplicación y servicios externos.

## 4. Análisis STRIDE

| Categoría | Amenaza | Medida de protección |
|---|---|---|
| Spoofing | Suplantación de un estudiante o profesor. | Autenticación segura y JWT firmado. |
| Tampering | Modificación de notas o evaluaciones. | Validación de datos y controles de autorización. |
| Repudiation | Un usuario niega haber realizado una acción. | Registros de auditoría y trace_id. |
| Information Disclosure | Exposición de datos personales de estudiantes. | Cifrado, control de acceso y sanitización de logs. |
| Denial of Service | Saturación de los endpoints del backend. | Rate limiting y límites de solicitudes. |
| Elevation of Privilege | Un estudiante obtiene permisos de administrador. | RBAC y principio de mínimo privilegio. |

## 5. Priorización de riesgos

- Alto: exposición de datos personales y modificación
  no autorizada de calificaciones.
- Alto: acceso indebido a funciones administrativas.
- Medio: saturación de servicios mediante solicitudes.
- Medio: falta de trazabilidad de acciones.

## 6. Mitigaciones

1. Aplicar autenticación y autorización en el backend.
2. Validar los permisos antes de modificar información.
3. Evitar almacenar contraseñas y tokens en el código.
4. Proteger los datos personales y sanitizar los logs.
5. Registrar las operaciones importantes.
6. Aplicar límites de solicitudes a los endpoints públicos.

## 7. Conclusión

El análisis STRIDE permite identificar amenazas
que pueden afectar la confidencialidad, integridad
y disponibilidad de AulaViva.

Las medidas propuestas ayudan a proteger los datos
de los estudiantes y mantener la seguridad
de los servicios de la plataforma.
