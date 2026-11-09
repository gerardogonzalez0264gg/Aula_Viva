# Modelo de amenazas STRIDE - AulaViva

## 1. Objetivo

Identificar las principales amenazas de seguridad que pueden afectar a AulaViva y definir medidas de protección para reducir los riesgos en el backend, la base de datos y el servicio Tutor IA.

El análisis utiliza la metodología STRIDE para identificar amenazas relacionadas con la autenticación, integridad de la información, confidencialidad y disponibilidad de los servicios.

## 2. Activos importantes

- Datos personales de estudiantes y profesores.
- Información de cursos y evaluaciones.
- Respuestas y calificaciones de los estudiantes.
- Credenciales, contraseñas y tokens de autenticación.
- Información procesada por el servicio Tutor IA.
- Servicios backend y base de datos.
- Instrucciones y respuestas generadas por Tutor IA.
- Claves API y configuraciones de servicios externos.

## 3. Límites de confianza

Se identifican los siguientes límites de confianza dentro de la plataforma:

- **Estudiante y plataforma AulaViva:** los usuarios deben autenticarse antes de acceder a sus recursos.
- **Frontend y backend:** el backend debe validar las solicitudes y no confiar directamente en los datos enviados por el frontend.
- **Backend y servicio Tutor IA:** se debe controlar la información enviada y recibida para evitar accesos o filtraciones de datos.
- **Servicios internos y base de datos:** el acceso debe estar restringido según los permisos necesarios.
- **Aplicación y servicios externos:** las comunicaciones deben protegerse mediante conexiones seguras y credenciales gestionadas correctamente.

## 4. Análisis STRIDE

| Categoría | Amenaza | Medida de protección |
|---|---|---|
| Spoofing | Suplantación de un estudiante o profesor mediante credenciales robadas. | Autenticación segura, contraseñas protegidas y JWT firmado. |
| Tampering | Modificación no autorizada de notas o evaluaciones. | Validación de datos, controles de autorización y auditoría de cambios. |
| Tampering | Manipulación de instrucciones enviadas al servicio Tutor IA. | Validación de entradas y separación entre instrucciones del sistema y contenido del usuario. |
| Repudiation | Un usuario niega haber realizado una acción dentro de la plataforma. | Registros de auditoría, identificación del usuario y trace_id. |
| Information Disclosure | Exposición de datos personales de estudiantes. | Cifrado, control de acceso y sanitización de logs. |
| Information Disclosure | Tutor IA entrega información privada de otros estudiantes o cursos. | Control de acceso, validación del contexto y filtrado de información sensible. |
| Denial of Service | Saturación de los endpoints del backend mediante solicitudes excesivas. | Rate limiting y límites de solicitudes. |
| Elevation of Privilege | Un estudiante obtiene permisos de profesor o administrador. | Control de acceso basado en roles (RBAC) y principio de mínimo privilegio. |

## 5. Priorización de riesgos

- **Alto:** exposición de datos personales de estudiantes.
- **Alto:** modificación no autorizada de calificaciones y evaluaciones.
- **Alto:** acceso indebido a funciones administrativas.
- **Alto:** exposición de información privada mediante respuestas de Tutor IA.
- **Medio:** saturación de servicios mediante solicitudes excesivas.
- **Medio:** manipulación de instrucciones enviadas a Tutor IA.
- **Medio:** falta de trazabilidad de las acciones realizadas por los usuarios.

## 6. Mitigaciones

1. Aplicar autenticación y autorización en el backend.
2. Validar los permisos de los usuarios antes de modificar información.
3. Evitar almacenar contraseñas, tokens y claves API directamente en el código fuente.
4. Proteger los datos personales mediante controles de acceso y cifrado.
5. Sanitizar los registros para evitar almacenar información sensible.
6. Registrar las operaciones importantes mediante logs de auditoría.
7. Aplicar límites de solicitudes a los endpoints públicos para reducir ataques de denegación de servicio.
8. Validar la información enviada al servicio Tutor IA para reducir riesgos de manipulación de instrucciones.
9. Evitar que Tutor IA acceda o entregue información que no corresponda a los permisos del usuario.
10. Proteger las comunicaciones entre los servicios mediante conexiones seguras.

## 7. Conclusión

El análisis STRIDE permite identificar las principales amenazas que pueden afectar la confidencialidad, integridad y disponibilidad de AulaViva.

Se identificaron riesgos relacionados con la suplantación de identidad, modificación de información, exposición de datos personales, denegación de servicio y elevación de privilegios.

Además, se consideran amenazas específicas del servicio Tutor IA, especialmente la exposición de información privada y la manipulación de instrucciones.

Las medidas propuestas ayudan a reducir estos riesgos, proteger los datos de los estudiantes y mantener la seguridad de los servicios de la plataforma.
