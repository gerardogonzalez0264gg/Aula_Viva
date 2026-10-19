# ADR 0005: Plataforma de contenedores, Kubernetes e IaC

## Contexto

AulaViva se despliega como dos contenedores: Backend (Node.js) y Servicio IA (Python), según el ADR 0003.
Hay que decidir cómo se empaquetan, dónde se orquestan y cómo se describe la infraestructura.
La clase pide Dockerfile, manifiestos de Kubernetes y Terraform.

## Alternativas

**Imagen base**
- Imagen normal (`node:20`, `python:3.11`).
- Alpine.
- Distroless.

**Kubernetes para practicar**
- kind.
- minikube.
- k3d.

**Infraestructura como código**
- Terraform.
- Pulumi.
- CloudFormation.

**Organizar los manifiestos**
- Helm.
- Kustomize.

## Decisión

- **Imagen base: distroless** (`gcr.io/distroless/nodejs20-debian12` y `python3-debian12`), con **build en dos etapas** y usuario no-root.
- **Kubernetes local: kind.** Es liviano, corre sobre Docker y es fácil de borrar y volver a crear.
- **IaC: Terraform**, con el estado guardado en un bucket remoto de Google Cloud (GCS), un estado por ambiente.
- **Manifiestos: Kustomize**, porque está integrado en `kubectl` y permite usar `base` + `overlays` por ambiente (se usa en la S08).
- **Etiqueta de imagen:** por digest (`@sha256:...`), nunca `:latest`.
- **Dos Deployments separados** (Backend e IA), cada uno con su propio autoescalado (HPA).

## Justificación

- Distroless no trae shell ni herramientas extra, entonces hay menos cosas que puedan tener fallas de seguridad y la imagen pesa menos.
- Es importante para AulaViva por los datos de menores: menos superficie de ataque.
- Escalar el Servicio IA por separado evita que los picos de evaluaciones tumben al Backend.
- Terraform funciona con cualquier nube; si se cambia de proveedor, se reutiliza lo aprendido.
- Kustomize es más simple que Helm para un equipo pequeño y no hay que aprender un lenguaje de plantillas.

## Consecuencias positivas

- Imágenes pequeñas, reproducibles y sin permisos de administrador.
- Despliegues iguales en todos los ambientes.
- La infraestructura queda escrita en archivos y revisable en un pull request.

## Consecuencias negativas

- Con distroless no se puede entrar al contenedor a depurar (no hay shell); hay que apoyarse en los logs.
- Terraform exige cuidar el estado (no subirlo a Git, usar bloqueo).
- Hay más archivos que mantener (Dockerfile, manifiestos y Terraform).

## Fecha

19-10-2026

## Autor

Gerardo González
