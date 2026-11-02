# ADR 0005: Estrategia GitOps para desplegar AulaViva

## Contexto

AulaViva ya tiene contenedores y manifiestos de Kubernetes (S07).
Falta decidir cómo se despliegan los cambios al cluster y cómo se revisan antes de salir.

## Alternativas

**Cómo desplegar**
- Push: el pipeline ejecuta `kubectl apply` directo en el cluster.
- Pull (GitOps): un programa dentro del cluster mira Git y se actualiza solo.

**Herramienta GitOps**
- Argo CD.
- Flux.

**Estrategia de ramas**
- Trunk-based.
- GitHub Flow.
- GitFlow.

## Decisión

- **Pull (GitOps)** con **Argo CD**.
- Dos repos: uno con el código (`Aula_Viva`) y otro con los manifiestos (`aulaviva-gitops`), con Kustomize `base` + `overlays/dev` y `overlays/prod`.
- El pipeline publica la imagen y abre un pull request en el repo GitOps; al aprobarlo, Argo CD actualiza el cluster.
- **GitHub Flow** con `main` protegida: pull request obligatorio, 2 revisores y checks en verde.

## Justificación

- Con pull no hay que guardar claves del cluster en GitHub.
- Todo cambio queda en Git, se revisa y se puede deshacer con un revert.
- Argo CD tiene pantalla visual, útil para mostrar el estado al equipo.
- GitHub Flow es simple para un equipo de 5 con releases frecuentes.

## Consecuencias positivas

- Despliegues auditables y reversibles.
- El cluster siempre refleja lo que está en Git.
- Se detecta si alguien cambia algo a mano (Argo lo corrige).

## Consecuencias negativas

- Hay que mantener dos repositorios.
- Hay que instalar y cuidar Argo CD en el cluster.
- Cada versión necesita un pull request extra en el repo GitOps.

## Fecha

02-11-2026

## Autor

Gerardo González
