## Estructura del repositorio

| Carpeta o archivo | Qué contiene |
|---|---|
| `api/` | Contrato OpenAPI de la API |
| `docs/` | Documentación (ADR, C4, datos, backlog, 12-factor) |
| `backend/` | Backend (Node.js) y su Dockerfile |
| `ai-service/` | Servicio IA (Python) y su Dockerfile |
| `k8s/` | Manifiestos de Kubernetes (se aplican con Kustomize) |
| `terraform/` | Infraestructura como código |
| `.github/workflows/` | Pipelines de GitHub Actions |
| `docker-compose.yml` | Para levantar todo en el computador |

## Cómo ejecutar en el computador

```bash
docker compose up --build
```

- Backend: http://localhost:8080/health
- Servicio IA: http://localhost:8081/health

## Despliegue en Kubernetes (S07)

```bash
kind create cluster --name aulaviva
kubectl apply -k k8s/
kubectl get all -n aulaviva
```

Captura del resultado de `kubectl get all -n aulaviva`:

![kubectl get all](docs/img/kubectl-get-all.png)

Decisiones: ver `docs/adr/0005-plataforma-k8s.md`.

## CI/CD y GitOps (S08)

- El pipeline está en `.github/workflows/ci.yml` (revisión de código, pruebas con 70% de cobertura, Semgrep e imágenes en GHCR).
- Los manifiestos de despliegue viven en el repositorio `aulaviva-gitops` y Argo CD los aplica solo.
- Decisiones: ver `docs/adr/0006-gitops-strategy.md`.

Captura de Argo CD con la aplicación en Synced/Healthy:

![Argo CD](docs/img/argocd-synced.png)

## Decisiones de arquitectura (ADR)

| ADR | Tema |
|---|---|
| 0001 | Elección de la iniciativa |
| 0002 | Estilo arquitectónico |
| 0003 | Despliegue en la nube |
| 0004 | Datos y eventos |
| 0005 | Contenedores, Kubernetes e IaC |
| 0006 | CI/CD y GitOps |
